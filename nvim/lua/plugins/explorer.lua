local Snacks = require("snacks")
local uv = vim.uv or vim.loop

local function remove_path(path)
  local stat, err = uv.fs_lstat(path)
  if not stat then
    if err and not err:find("ENOENT", 1, true) then
      return false, err
    end
    return true
  end

  if stat.type == "directory" then
    local handle
    handle, err = uv.fs_scandir(path)
    if not handle then
      return false, err
    end
    while true do
      local name = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      local ok
      ok, err = remove_path(path .. "/" .. name)
      if not ok then
        return false, err
      end
    end
    return uv.fs_rmdir(path)
  end

  return uv.fs_unlink(path)
end

local function copy_path(from, to)
  local stat, err = uv.fs_lstat(from)
  if not stat then
    return false, err
  end

  if stat.type == "directory" then
    local ok
    ok, err = uv.fs_mkdir(to, bit.band(stat.mode, 511))
    if not ok then
      return false, err
    end

    local handle
    handle, err = uv.fs_scandir(from)
    if not handle then
      return false, err
    end
    while true do
      local name = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      ok, err = copy_path(from .. "/" .. name, to .. "/" .. name)
      if not ok then
        return false, err
      end
    end
    return true
  end

  if stat.type == "link" then
    local target
    target, err = uv.fs_readlink(from)
    if not target then
      return false, err
    end
    local target_stat = uv.fs_stat(from)
    local flags = jit.os == "Windows" and { dir = target_stat and target_stat.type == "directory" } or nil
    return uv.fs_symlink(target, to, flags)
  end

  if stat.type ~= "file" then
    return false, "Unsupported entry type: " .. stat.type
  end

  local ok
  ok, err = uv.fs_copyfile(from, to, { excl = true, ficlone = true })
  return ok, err
end

local function path_key(path)
  path = vim.fs.normalize(vim.fs.abspath(path))
  local parts = {}
  local resolved = uv.fs_realpath(path)
  while not resolved do
    local parent = vim.fs.dirname(path)
    if not parent or parent == path then
      break
    end
    table.insert(parts, 1, vim.fs.basename(path))
    path = parent
    resolved = uv.fs_realpath(path)
  end
  if resolved then
    path = resolved
    for _, part in ipairs(parts) do
      path = path .. "/" .. part
    end
  end
  path = vim.fs.normalize(path)
  return jit.os == "Windows" and path:lower() or path
end

local function is_same_or_descendant(path, parent)
  path, parent = path_key(path), path_key(parent)
  local prefix = parent:sub(-1) == "/" and parent or parent .. "/"
  return path == parent or path:sub(1, #prefix) == prefix
end

local function copy(from, to)
  local stat = uv.fs_lstat(from)
  if not stat then
    Snacks.notify.error(("File `%s` does not exist"):format(from))
    return false
  elseif uv.fs_lstat(to) then
    Snacks.notify.warn("File already exists:\n- `" .. to .. "`")
    return false
  elseif stat.type == "directory" and is_same_or_descendant(to, from) then
    Snacks.notify.error(("Cannot copy a directory into itself:\n- from: `%s`\n- to: `%s`"):format(from, to))
    return false
  end

  local ok, mkdir_err = pcall(vim.fn.mkdir, vim.fs.dirname(to), "p")
  if not ok then
    Snacks.notify.error(("Failed to create directory:\n- `%s`\n%s"):format(vim.fs.dirname(to), mkdir_err))
    return false
  end

  local err
  ok, err = copy_path(from, to)
  if not ok then
    local cleanup_ok, cleanup_err = remove_path(to)
    local cleanup = not cleanup_ok and "\nFailed to clean up:\n" .. cleanup_err or ""
    Snacks.notify.error(
      ("Failed to copy:\n- from: `%s`\n- to: `%s`\n%s%s"):format(from, to, err or "Unknown error", cleanup)
    )
    return false
  end
  return true
end

local function explorer_copy(picker, item)
  if not item then
    return
  end

  local Actions = require("snacks.explorer.actions")
  local Tree = require("snacks.explorer.tree")
  local Util = require("snacks.picker.util")
  local paths = vim.tbl_map(Util.path, picker:selected())

  -- Copy selection
  if #paths > 0 then
    local dir = picker:dir()
    for _, from in ipairs(paths) do
      local to = dir .. "/" .. vim.fn.fnamemodify(from, ":t")
      copy(from, to)
    end
    picker.list:set_selected() -- clear selection
    Tree:refresh(dir)
    Tree:open(dir)
    Actions.update(picker, { target = dir })
    return
  end

  Snacks.input({
    prompt = "Copy to",
  }, function(value)
    if not value or value:find("^%s*$") then
      return
    end
    local from = Util.path(item)
    local to = vim.fs.normalize(vim.fs.dirname(from) .. "/" .. value)
    if copy(from, to) then
      Tree:refresh(vim.fs.dirname(to))
      Actions.update(picker, { target = to })
    end
  end)
end

local function smart_explorer(dir)
  local picker = Snacks.picker.get({ source = "explorer" })[1]
  if not picker then
    Snacks.explorer({ cwd = dir })
    return
  end
  if picker:cwd() == dir then
    return
  end
  local A = require("snacks.explorer.actions")
  pcall(function()
    picker:set_cwd(dir)
    A.actions.explorer_update(picker)
  end)
end

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = { preset = "sidebar", preview = false },
          win = {
            input = {
              keys = {
                ["<Esc>"] = false,
              },
            },
            list = {
              keys = {
                ["<Esc>"] = false,
              },
            },
          },
          actions = {
            explorer_copy = explorer_copy,
          },
        },
      },
      ui_select = true,
    },
    explorer = {
      auto_close = true,
    },
  },
  keys = {
    {
      "<leader>je",
      mode = { "n" },
      function()
        local reveal_file = vim.fn.expand("%:p:h")
        if reveal_file == "" then
          reveal_file = vim.fn.getcwd()
        end
        smart_explorer(reveal_file)
      end,
      desc = "Explore current file or buffer",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Toggle Explorer (Root Dir)",
    },
    {
      "<leader>E",
      function()
        Snacks.explorer({ cwd = vim.fn.getcwd() })
      end,
      desc = "Toggle Explorer (cwd)",
    },
    {
      "<leader>fe",
      function()
        smart_explorer(LazyVim.root())
      end,
      desc = "Explorer (Root Dir)",
    },
    {
      "<leader>fE",
      function()
        smart_explorer(vim.fn.getcwd())
      end,
      desc = "Explorer (cwd)",
    },
  },
}

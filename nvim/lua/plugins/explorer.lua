local Snacks = require("snacks")
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
        },
      },
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

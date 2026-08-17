-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- 1. K 大写K可以查看光标下单词的帮助文档

-- Add any additional keymaps here

-- 映射leader + jb为切换到当前文件所在目录
vim.keymap.set(
  "n",
  "<leader>jb",
  ":cd %:p:h<CR>:pwd<CR>",
  { noremap = true, silent = false, desc = "CD to Current Buffer" }
)

-- 复制并显示当前文件的绝对路径
vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", path)
  print(path)
end, { desc = "Copy Current File Path" })

-- 映射leader + jr为切换到LazyVim根目录
if LazyVim then
  vim.keymap.set("n", "<leader>jr", function()
    vim.cmd("cd " .. LazyVim.root())
  end, { desc = "CD to LazyRoot" })
end

local function snacks_grep_in_dir(dir)
  if not (Snacks and Snacks.picker and Snacks.picker.grep) then
    vim.notify("Snacks picker is not available", vim.log.levels.WARN)
    return
  end
  Snacks.picker.grep({ cwd = dir })
end

local function snacks_grep_word_in_dir(dir, word)
  if not (Snacks and Snacks.picker and Snacks.picker.grep) then
    vim.notify("Snacks picker is not available", vim.log.levels.WARN)
    return
  end
  Snacks.picker.grep({ cwd = dir, search = word })
end

-- 搜当前文件所在目录内容
vim.keymap.set("n", "<leader>jg", function()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end
  snacks_grep_in_dir(dir)
end, { desc = "Grep in Current File Dir" })

-- 用光标词搜索当前文件所在目录
vim.keymap.set("n", "<leader>jw", function()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end

  local word = vim.fn.expand("<cword>")
  if not word or word == "" then
    vim.notify("No word under cursor", vim.log.levels.INFO)
    return
  end

  snacks_grep_word_in_dir(dir, word)
end, { desc = "Grep cword in Current File Dir" })

-- 输入目录后搜索内容
vim.keymap.set("n", "<leader>jG", function()
  local default_dir = vim.fn.expand("%:p:h")
  if default_dir == "" then
    default_dir = vim.fn.getcwd()
  end

  vim.ui.input({
    prompt = "Grep directory: ",
    default = default_dir,
    completion = "dir",
  }, function(input)
    if not input or input == "" then
      return
    end

    local dir = vim.fn.fnamemodify(vim.fn.expand(input), ":p")
    if vim.fn.isdirectory(dir) ~= 1 then
      vim.notify("Not a directory: " .. dir, vim.log.levels.ERROR)
      return
    end

    snacks_grep_in_dir(dir)
  end)
end, { desc = "Grep in Selected Dir" })

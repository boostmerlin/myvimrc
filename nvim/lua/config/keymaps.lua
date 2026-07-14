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

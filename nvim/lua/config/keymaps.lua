-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 映射leader + .为切换到当前文件所在目录
vim.keymap.set("n", "<leader>..", ":cd %:p:h<CR>:pwd<CR>", { noremap = true, silent = true, desc = "CD by Buffer" })

if LazyVim then
  vim.keymap.set("n", "<leader>.r", function()
    vim.cmd("cd " .. LazyVim.root())
  end, { desc = "CD to LazyRoot" })
end

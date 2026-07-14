-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config.performance")

-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = false

-- for Avante, but don't know how it works
vim.opt.laststatus = 3

-- vim.opt.grepprg = "rg --vimgrep --smart-case"
-- vim.opt.grepformat = "%f:%l:%c:%m"

if vim.fn.has("win32") == 1 then
  vim.opt.shellpipe = ">%s 2>&1"
end
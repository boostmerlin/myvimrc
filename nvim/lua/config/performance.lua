-- 性能优化配置
-- 添加到 options.lua

-- 禁用一些不必要的功能以提高性能
vim.g.loaded_python3_provider = 0  -- 打开python文件会卡一会，设置为0则不会卡
vim.g.loaded_node_provider = 0     -- 如果不使用 Node.js 提供程序
vim.g.loaded_perl_provider = 0     -- 如果不使用 Perl 提供程序
vim.g.loaded_ruby_provider = 0     -- 如果不使用 Ruby 提供程序

local M = {}

-- 启用 Python3 provider
function M.enable_python3()
  vim.g.loaded_python3_provider = nil
  vim.cmd('runtime! autoload/provider/python3.vim')
  vim.notify("Python3 provider enabled", vim.log.levels.INFO)
end

-- 启用 Node.js provider
function M.enable_node()
  vim.g.loaded_node_provider = nil
  vim.cmd('runtime! autoload/provider/node.vim')
  vim.notify("Node.js provider enabled", vim.log.levels.INFO)
end

-- 启用 Ruby provider
function M.enable_ruby()
  vim.g.loaded_ruby_provider = nil
  vim.cmd('runtime! autoload/provider/ruby.vim')
  vim.notify("Ruby provider enabled", vim.log.levels.INFO)
end

-- 启用 Perl provider
function M.enable_perl()
  vim.g.loaded_perl_provider = nil
  vim.cmd('runtime! autoload/provider/perl.vim')
  vim.notify("Perl provider enabled", vim.log.levels.INFO)
end

function M.enable_all()
  M.enable_python3()
  M.enable_node()
  M.enable_ruby()
  M.enable_perl()
end

vim.api.nvim_create_user_command('EnablePython3', M.enable_python3, {})
vim.api.nvim_create_user_command('EnableNode', M.enable_node, {})
vim.api.nvim_create_user_command('EnableRuby', M.enable_ruby, {})
vim.api.nvim_create_user_command('EnablePerl', M.enable_perl, {})
vim.api.nvim_create_user_command('EnableAllProviders', M.enable_all, {})
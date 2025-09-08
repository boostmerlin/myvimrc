-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 自动安装 treesitter 解析器
local function auto_install_treesitter()
  local ft_to_lang = {
    -- cpp = "cpp",
    -- c = "c",
    -- cmake = "cmake",
    -- rust = "rust",
    -- python = "python",
    -- javascript = "javascript",
    -- typescript = "typescript",
    -- lua = "lua",
    -- go = "go",
    -- java = "java",
  }
  
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local filetype = args.match
      local lang = ft_to_lang[filetype]
      
      if lang then
        -- 检查解析器是否已安装
        local parsers = require("nvim-treesitter.parsers")
        if not parsers.has_parser(lang) then
          vim.notify("Installing treesitter parser for " .. lang, vim.log.levels.INFO)
          vim.cmd("TSInstall " .. lang)
        end
      end
    end,
  })
end

-- 延迟执行以确保 treesitter 已加载
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(args)
    if args.data == "nvim-treesitter" then
      auto_install_treesitter()
    end
  end,
})

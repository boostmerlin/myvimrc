return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- -- 启用自动安装
    -- opts.auto_install = true
    
    -- 定义要移除的语言列表
    local remove_list = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    }
    
    local add_list = {
      -- "cpp",
      -- "cmake",
      -- "rust",
    }
    
    local remove_set = {}
    for _, lang in ipairs(remove_list) do
      remove_set[lang] = true
    end
    
    local filtered_installed = {}
    for _, lang in ipairs(opts.ensure_installed or {}) do
      if not remove_set[lang] then
        table.insert(filtered_installed, lang)
      end
    end
    
    for _, lang in ipairs(add_list) do
      table.insert(filtered_installed, lang)
    end
    
    opts.ensure_installed = filtered_installed
    return opts
  end,
}
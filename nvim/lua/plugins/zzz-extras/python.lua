return {
  -- Python 相关的自定义配置
  -- LazyVim 的 Python/DAP/Test extras 由 config.lazy 根据 workspace-nvim.json 先导入。
  {
    -- windows 下<leader>tt vim.fn.expand("%") 得到的路径似乎不能被 neotest 识别
    -- 形如: d:/path/to/file.py，而 neotest 需要 d:\path\to\file.py; 但是处理路径后仍然有问题，output会显示乱码！
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },

    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },

    -- keys = {
    --   {
    --     "<leader>tt",
    --     function()
    --       -- 运行当前文件的所有测试
    --       local file_path = vim.fn.expand("%:p")
          
    --       -- 在 Windows 下规范化路径
    --       if vim.fn.has("win32") == 1 then
    --         file_path = file_path:gsub("/", "\\")
    --       end
          
    --       require("neotest").run.run(file_path)
    --     end,
    --     desc = "Run current file tests",
    --   },
    -- }, -- END OF keys
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" },
    },
  },
}

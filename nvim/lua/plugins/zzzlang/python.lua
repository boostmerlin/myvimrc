return {
  -- Python 相关的自定义配置
  -- extras 可以在 lazyvim.json 中启用：
  -- - lazyvim.plugins.extras.dap.core
  -- - lazyvim.plugins.extras.lang.python  
  -- - lazyvim.plugins.extras.test.core
  
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },
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

local ws = require("workspace")

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "cpplint")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        cpp = { "cpplint" },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    opts = {
      -- NOTE: this is left here for future porting in case needed
      -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Daps are not automatically installed.
      --   - true: All adapters set up via dap are automatically installed.
      --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "python", "delve" } }
      automatic_installation = false,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      -- https://github.com/jay-babu/mason-nvim-dap.nvim
      handlers = {},

      -- A list of adapters to install if they're not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {
        "cppdbg",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local clangd = opts.servers.clangd
      local config = ws.getOrDefault("cpp", "clangd", {})
      local path_prepend = config.path_prepend or {}

      -- 保证 g++ 启动 cc1plus.exe 时能找到 MinGW 的 DLL
      if #path_prepend > 0 then
        local separator = package.config:sub(1, 1) == "\\" and ";" or ":"
        clangd.cmd_env = clangd.cmd_env or {}
        clangd.cmd_env.PATH = table.concat(path_prepend, separator) .. separator .. vim.env.PATH
      end

      -- 允许 clangd 查询 GCC 的标准库头文件和目标平台
      local query_drivers = config.query_drivers or {}
      if #query_drivers > 0 then
        clangd.cmd = clangd.cmd or { "clangd" }
        local query_driver = "--query-driver=" .. table.concat(query_drivers, ",")

        if not vim.tbl_contains(clangd.cmd, query_driver) then
          table.insert(clangd.cmd, query_driver)
        end
      end
    end,
  },
}

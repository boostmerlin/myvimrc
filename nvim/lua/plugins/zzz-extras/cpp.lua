return {
  {
    "williamboman/mason.nvim",
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
        "cppdbg"
      },
    }
  },
}

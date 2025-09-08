return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      handlers = {},
      -- A list of adapters to install if they're not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {
        "python",
      },
      automatic_installation = false,
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    event = "VeryLazy",
    opts = {
      adapters = {
        require("neotest-python")({
          -- Here you can specify the settings for the adapter, i.e.
          dap = { justMyCode = false },
          runner = "pytest",
          args = { "--log-level", "DEBUG" },
          -- python = ".venv/bin/python",
          pytest_discover_instances = true,
        }),
      },
    },
  },
}

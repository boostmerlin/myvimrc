return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  opts = {
    handlers = {},
    -- A list of adapters to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {
      "python"
    }
  },
  {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-python",
  },
  opts = {
        adapters = {
          ["neotest-python"] = {
            -- Here you can specify the settings for the adapter, i.e.
            runner = "pytest",
            -- python = ".venv/bin/python",
          },
      },
    },
  },
}

-- Extend nvim-dap with Visual Studio-like F-key mappings via lazy.nvim plugin spec
-- This file ensures mappings are only active when nvim-dap is installed/loaded.
if LazyVim.has("nvim-dap") then
  return {
    -- Optional: persistent breakpoints (disabled by default; toggle enabled=true to use)
    {
      "Weissle/persistent-breakpoints.nvim",
      enabled = true,
      event = "VeryLazy",
      opts = {
        load_breakpoints_event = { "BufReadPost" },
      },
      config = function(_, opts)
        require("persistent-breakpoints").setup(opts)
      end,
    },
    -- nvim-dap and F-key mappings
    {
      "mfussenegger/nvim-dap",
      keys = {
        {
          "<S-F8>",
          function()
            local ok, pb = pcall(require, "persistent-breakpoints.api")
            if ok and pb.clear_breakpoints then
              -- clear breakpoints in current buffer/file via persistent-breakpoints
              pb.clear_breakpoints()
              return
            end
            -- fallback: try nvim-dap per-file clear, then clear all if unsupported
            local dap = require("dap")
            local file = vim.api.nvim_buf_get_name(0)
            local tried = pcall(dap.clear_breakpoints, { file = file })
            if not tried then
              tried = pcall(dap.clear_breakpoints, file)
            end
            if not tried then
              dap.clear_breakpoints()
            end
          end,
          mode = { "n", "i" },
          desc = "DAP: Clear File Breakpoints",
        },
        {
          "<F8>",
          function()
            local ok, pb = pcall(require, "persistent-breakpoints.api")
            if ok and pb.clear_all_breakpoints then
              pb.clear_all_breakpoints()
            else
              require("dap").clear_breakpoints()
            end
          end,
          mode = { "n", "i" },
          desc = "DAP: Clear All Breakpoints",
        },
        {
          "<F5>",
          function()
            require("dap").continue()
          end,
          mode = { "n", "i" },
          desc = "DAP: Continue",
        },
        {
          "<F9>",
          function()
            local ok, pb = pcall(require, "persistent-breakpoints.api")
            if ok then
              pb.toggle_breakpoint()
            else
              require("dap").toggle_breakpoint()
            end
          end,
          mode = { "n", "i" },
          desc = "DAP: Toggle Breakpoint",
        },
        {
          "<F10>",
          function()
            require("dap").step_over()
          end,
          mode = { "n", "i" },
          desc = "DAP: Step Over",
        },
        {
          "<F11>",
          function()
            require("dap").step_into()
          end,
          mode = { "n", "i" },
          desc = "DAP: Step Into",
        },
        {
          "<S-F11>",
          function()
            require("dap").step_out()
          end,
          mode = { "n", "i" },
          desc = "DAP: Step Out",
        },
      },
    },
  }
end

return {}

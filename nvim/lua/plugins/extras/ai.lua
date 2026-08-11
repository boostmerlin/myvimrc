-- Avante is enabled from workspace-nvim.json via extras.
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- do not set to "*"
    -- Build: PowerShell on Windows, make on other platforms (per upstream README)
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
      -- Optional: image paste support (Windows: set use_absolute_path = true)
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      -- Optional: Markdown renderer with Avante filetype support
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
        opts = { file_types = { "markdown", "Avante" } },
      },
    },
    ---@type avante.Config
    opts = {
      -- Automatically read this file at project root as context
      instructions_file = "avante.md",
      -- Provider selection: use GitHub Copilot
      provider = "copilot",
      -- Stability: disable auto suggestions to avoid rare highlight edge cases
      behaviour = {
        auto_suggestions = false,
        auto_focus_sidebar = true,
        auto_approve_tool_permissions = false,
      },
      -- Increase debounce/throttle to reduce frequent triggers
      suggestion = {
        debounce = 800,
        throttle = 800,
      },
      providers = {
        copilot = {
          -- Authenticate via zbirenbaum/copilot.lua; no extra model config needed
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      if not vim.tbl_contains(opts.sources.default, "avante") then
        table.insert(opts.sources.default, "avante")
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.avante = {
        module = "blink-cmp-avante",
        name = "Avante",
        opts = {},
      }
    end,
  },
}

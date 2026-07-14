return {
  "saghen/blink.cmp",
  dependencies = {
    "moyiz/blink-emoji.nvim",
  },
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
    if not vim.tbl_contains(opts.sources.default, "emoji") then
      table.insert(opts.sources.default, "emoji")
    end

    opts.sources.providers = opts.sources.providers or {}
    opts.sources.providers.emoji = {
      name = "emoji",
      module = "blink-emoji",
      score_offset = 15,
    }

    opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
      preset = "default",
      ["<A-1>"] = {
        function(cmp)
          cmp.accept({ index = 1 })
        end,
      },
      ["<A-2>"] = {
        function(cmp)
          cmp.accept({ index = 2 })
        end,
      },
      ["<A-3>"] = {
        function(cmp)
          cmp.accept({ index = 3 })
        end,
      },
      ["<A-4>"] = {
        function(cmp)
          cmp.accept({ index = 4 })
        end,
      },
      ["<A-5>"] = {
        function(cmp)
          cmp.accept({ index = 5 })
        end,
      },
      ["<A-6>"] = {
        function(cmp)
          cmp.accept({ index = 6 })
        end,
      },
      ["<A-7>"] = {
        function(cmp)
          cmp.accept({ index = 7 })
        end,
      },
      ["<A-8>"] = {
        function(cmp)
          cmp.accept({ index = 8 })
        end,
      },
      ["<A-9>"] = {
        function(cmp)
          cmp.accept({ index = 9 })
        end,
      },
      ["<A-0>"] = {
        function(cmp)
          cmp.accept({ index = 10 })
        end,
      },
      ["<C-;>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-space>"] = false,
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_and_accept()
          else
            return false
          end
        end,
        "fallback",
      },
    })

    opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = { menu = { auto_show = false } },
    })
  end,
}

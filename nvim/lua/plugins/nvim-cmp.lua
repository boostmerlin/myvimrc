return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
  },
  -- do not use config, will overwrite cmp setup
  opts = function()
    local cmp = require("cmp")
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    vim.keymap.set("c", "<tab>", "<C-z>", { silent = false }) -- to fix cmp
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --   }, {
    --     { name = "cmdline" },
    --   }),
    -- })
  end,
}

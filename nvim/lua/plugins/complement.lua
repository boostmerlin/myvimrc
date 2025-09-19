return {
  "saghen/blink.cmp",
  dependencies = {
      "moyiz/blink-emoji.nvim",
  },
  opts = {
    sources = {
      -- default = { 'lsp', 'path', 'snippets', 'buffer' },
      default = {  'emoji' }, -- lazyvim will merge the opts
      providers = {
        emoji = {
          name = 'emoji',
          module = 'blink-emoji',
          score_offset = 15,
        },
      },
    },
    keymap = {
      preset = 'default',
      ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
      ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
      ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
      ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
      ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
      ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
      ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
      ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
      ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
      ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
      ['<C-;>'] = { 'show', 'show_documentation', 'hide_documentation' }, 
      ['<C-space>'] = false, --<C-space> is for input
      ['<Tab>'] = { 
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_and_accept()
          else
            return false
          end
        end,
        'fallback'
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = { menu = { auto_show = false } },
    },
  },
}

return {
  "boostmerlin/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {
     hint_config = {
        float_opts = {
            border = 'rounded',
        },
        position = 'bottom-right',
    },
    generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = {
            column_count = 1,
            max_hint_length = 33,
        },
    },
  },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<leader>mm",
      "<cmd>MCstart<cr>",
      desc = "MC on Word or Visual",
    },
    {
      mode = { "n", "v" },
      "<leader>mp",
      function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" or mode == "\x16" then
          vim.cmd("MCvisualPattern")
        else
          vim.cmd("MCpattern")
        end
      end,
      desc = "MC on Pattern (visual or normal)",
    },
    {
      mode = { "n" },
      "<leader>mn",
      "<cmd>MCunderCursor<cr>",
      desc = "MC under Char",
    },
    {
      mode = { "n" },
      "<leader>mv",
      "<cmd>MCvisual<cr>",
      desc = "MC on Last Visual(gv)",
    },
    {
      "<C-n>",
      "<leader>mm",
      desc = "MC on Word or Visual",
      remap = true,
    },
  },
}

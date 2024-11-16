return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {},
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<leader>mm",
      "<cmd>MCstart<cr>",
      desc = "MC on Word or Visual",
    },
    {
      mode = { "v", "n" },
      "<leader>mvp",
      "<cmd>MCvisualPattern<cr>",
      desc = "MC on (last)Visual with Pattern",
    },
    {
      mode = { "n" },
      "<leader>mc",
      "<cmd>MCunderCursor<cr>",
      desc = "MC under Char",
    },
    {
      mode = { "n" },
      "<leader>ml",
      "<cmd>MCvisual<cr>",
      desc = "MC on Last Visual(gv)",
    },
    {
      mode = { "n" },
      "<leader>mp",
      "<cmd>MCpattern<cr>",
      desc = "MC on Pattern",
    },
    {
      "<C-j>",
      "<leader>mm",
      desc = "MC on Word or Visual",
      remap = true,
    },
  },
}

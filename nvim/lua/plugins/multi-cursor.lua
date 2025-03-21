return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "multi cursor" },
      },
    },
  },
  {
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
        "<leader>mn",
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
        "<C-n>",
        "<leader>mm",
        desc = "MC on Word or Visual",
        remap = true,
      },
    },
  },
}


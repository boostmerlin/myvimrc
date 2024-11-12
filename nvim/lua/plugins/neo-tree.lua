return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
      end,
      desc = "Toggle NeoTree (Root Dir)",
    },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Toggle NeoTree (cwd)",
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
    },
  },
}

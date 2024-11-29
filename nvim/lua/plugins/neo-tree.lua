return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>.E",
      mode = { "n" },
      function()
        local reveal_file = vim.fn.expand("%:p")
        if reveal_file == "" then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, "r")
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require("neo-tree.command").execute({
          action = "focus", -- OPTIONAL, this is the default value
          source = "filesystem", -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true, -- change cwd without asking if needed
        })
      end,
      desc = "Explore current file or working directory",
    },
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

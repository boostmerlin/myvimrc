return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "glsl_analyzer")
    end,
  },
  {
    "tikhomirov/vim-glsl",
  },
}

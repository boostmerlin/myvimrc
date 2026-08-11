return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "ltex-ls-plus")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex_plus = {
          filetypes = { "markdown", "text", "tex", "typst", "gitcommit" },
          settings = {
            ltex = {
              language = "auto",
              enabled = { "markdown", "text", "latex", "typst", "gitcommit" },
              additionalRules = { enablePickyRules = false },
            },
          },
        },
      },
    },
  },

  -- dev 分支：通过 LspAttach 自动识别 ltex / ltex_plus，无需 on_attach 手动挂载
  {
    "barreiroleo/ltex_extra.nvim",
    branch = "dev",
    ft = { "markdown", "text", "tex", "typst", "gitcommit" },
    opts = {
      load_langs = { "zh-CN", "en-US" },
      path = vim.fn.stdpath("config") .. "/spell",
    },
    -- LazyVim 对文本类型会强制开启内置 spell，ltex_plus 已接管该职责
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
  },
}

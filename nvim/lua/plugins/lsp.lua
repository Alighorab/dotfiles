return {
  { "neovim/nvim-lspconfig", config = require("plugins.lspconfig.core") },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      local on_attach = require("logan.utils.lsp").on_attach
      return {
        sources = {
          -- Formatters
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-ci" },
          }),
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.black.with({
            extra_args = {
              "--line-length",
              "88",
            },
          }),

          -- Linters
          null_ls.builtins.diagnostics.proselint.with({
            filetypes = { "markdown", "text", "rst" },
          }),

          -- Code Actions
          null_ls.builtins.code_actions.proselint.with({
            filetypes = { "markdown", "text", "rst" },
          }),

          -- Completion
          null_ls.builtins.completion.spell.with({
            filetypes = { "markdown", "text", "rst" },
          }),
        },
        on_attach = on_attach,
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
  "onsails/lspkind-nvim",
  { "j-hui/fidget.nvim", config = true },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
  },
  {
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-l>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
}

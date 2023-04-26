return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- diagnostics
      vim.diagnostic.config({
        virtual_text = true,
      })
      -- signs
      local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      -- servers
      require("plugins.language-servers.clangd").setup()
      require("plugins.language-servers.bashls").setup()
      require("plugins.language-servers.pylsp").setup()
      require("plugins.language-servers.gopls").setup()
      require("plugins.language-servers.rust-analyzer").setup()
      require("plugins.language-servers.lua_ls").setup()
    end,
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
      "onsails/lspkind-nvim",
      { "j-hui/fidget.nvim", config = true },
    },
  },
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

          -- Completion
          null_ls.builtins.completion.spell.with({
            filetypes = { "markdown", "text", "rst", "norg" },
          }),
        },
        on_attach = on_attach,
      }
    end,
    dependencies = {
      "onsails/lspkind-nvim",
      { "j-hui/fidget.nvim", config = true },
    },
  },
}

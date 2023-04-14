return {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/nvim-cmp",
  { "windwp/nvim-autopairs", config = true },
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    config = function()
      require("cmp_nvim_ultisnips").setup({
        filetype_source = "treesitter",
        show_snippets = "all",
        documentation = function(snippet)
          return snippet.description
        end,
      })
    end,
  },
  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath("config") .. "/ultisnips" }
    end,
  },
}

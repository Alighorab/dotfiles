return {
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "onsails/lspkind-nvim",
  { "j-hui/fidget.nvim", config = true },
  { "folke/trouble.nvim", config = true },
  "simrat39/rust-tools.nvim",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
}

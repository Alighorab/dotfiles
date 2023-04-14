return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          snippets = {
            icon = "",
            color = "#94e2d5",
            name = "Snippet",
          },
        },
      })
    end,
  },
  "norcalli/nvim-colorizer.lua",
  { "catppuccin/nvim", name = "catppuccin" },
}

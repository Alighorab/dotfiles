return {
  "kyazdani42/nvim-tree.lua",
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        columns = {
          -- "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        default_file_explorer = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["zh"] = "actions.toggle_hidden",
        },
      })
    end,
  },
  "nvim-lualine/lualine.nvim",
  "ThePrimeagen/harpoon",
  "akinsho/toggleterm.nvim",
  "CRAG666/code_runner.nvim",
  "folke/twilight.nvim",
  { "toppair/peek.nvim", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },
  "segeljakt/vim-silicon",
}

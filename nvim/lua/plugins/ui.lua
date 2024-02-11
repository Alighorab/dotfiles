return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        snippets = {
          icon = "",
          color = "#94e2d5",
          name = "Snippet",
        },
        gdb = {
          icon = "",
          color = "#800020",
          name = "GDB",
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "           ▄ ▄                   ",
        "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
        "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
        "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
        "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
        "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
        "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
        "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
        "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
      }
      dashboard.section.header.opts.hl = "DashboardHeader"

      local button = require("logan.utils.alpha").alpha_button
      dashboard.section.buttons.val = {
        button("g f f", "  Find File  "),
        button("g f g", "  Live Grep  "),
        button("LDR n", "  New File   "),
        button("g f o", "  Recents  "),
        button("LDR h u", "  Bookmarks  "),
      }

      dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
      dashboard.config.layout[3].val = 3
      dashboard.config.opts.noautocmd = true

      vim.cmd("au WinEnter,FileType alpha set cmdheight=0")
      vim.cmd("au WinLeave,FileType alpha set cmdheight=1")

      return dashboard
    end,
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "┊" },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "HampusHauffman/block.nvim",
    config = function()
      require("block").setup({})
    end,
  },
}

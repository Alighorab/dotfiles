-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local opts = {
  concurrency = 4, ---@type number limit the maximum amount of concurrent tasks
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "catppuccin" },
  },
}

-- Map leader key to <space>
vim.g.mapleader = " "

require("lazy").setup({
  -- Color schemes and icons
  "nvim-tree/nvim-web-devicons",
  "norcalli/nvim-colorizer.lua",
  { "catppuccin/nvim", name = "catppuccin" },

  -- Nvim Treesitter configurations and abstraction layer
  -- Treesitter:
  --   An incremental parsing system for programming tools.
  --   It can build a concrete syntax tree for a source file
  --   and efficiently update the syntax tree as the source file
  --   is edited.
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/playground",
  "andymass/vim-matchup",


  -- Telescope
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",

  -- LSP
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "glepnir/lspsaga.nvim",
  { "j-hui/fidget.nvim", config = true },
  { "folke/trouble.nvim", config = true },
  "simrat39/rust-tools.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  { "windwp/nvim-autopairs", config = true },

  -- DAP
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "nvim-telescope/telescope-dap.nvim",

  -- Package manager
  {
    "williamboman/mason.nvim",
    config = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      -- The directory in which to install packages.
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
    },
  },
  "williamboman/mason-lspconfig.nvim",
  "jayp0521/mason-nvim-dap.nvim",
  "jay-babu/mason-null-ls.nvim",

  -- Tpope
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "tpope/vim-eunuch",

  -- MISC
  "mbbill/undotree",
  { "numToStr/Comment.nvim", config = true },
  "kyazdani42/nvim-tree.lua",
  "nvim-lualine/lualine.nvim",
  "ThePrimeagen/harpoon",
  "akinsho/toggleterm.nvim",
  "CRAG666/code_runner.nvim",
  "vim-scripts/ReplaceWithRegister",
  "dstein64/vim-startuptime",
  "farmergreg/vim-lastplace",
  "folke/twilight.nvim",
  { "lewis6991/gitsigns.nvim", config = true },
  "toppair/peek.nvim",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },

  -- Useless
  "eandrju/cellular-automaton.nvim",
}, opts)

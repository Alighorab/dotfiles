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
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "netrwPlugin",
        "zipPlugin",
      },
    },
  },
}

-- Map leader key to <space>
vim.g.mapleader = " "

require("lazy").setup({
  -- Color schemes and icons
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

  -- Telescope
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",

  -- LSP
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "onsails/lspkind-nvim",
  { "j-hui/fidget.nvim", config = true },
  { "folke/trouble.nvim", config = true },
  "simrat39/rust-tools.nvim",

  -- Completion
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
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gg", vim.cmd.Git, desc = "fugitive" },
      {
        "<leader>gd",
        function()
          vim.cmd.Git("diff %")
        end,
        desc = "git diff",
      },
    },
  },
  "tpope/vim-eunuch",

  -- Utils
  "mbbill/undotree",
  "vim-scripts/ReplaceWithRegister",
  "farmergreg/vim-lastplace",
  { "numToStr/Comment.nvim", config = true },
  { "lewis6991/gitsigns.nvim", config = true },

  -- MISC
  "kyazdani42/nvim-tree.lua",
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
  {
    "segeljakt/vim-silicon",
  },

  -- Useless
  "eandrju/cellular-automaton.nvim",
}, opts)

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Color schemes and icons
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("akinsho/bufferline.nvim", {
		tag = "v3.*",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("morhetz/gruvbox")
	use("lilydjwg/colorizer")
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("sainnhe/gruvbox-material")

	-- Nvim Treesitter configurations and abstraction layer
	-- Treesitter:
	--   An incremental parsing system for programming tools.
	--   It can build a concrete syntax tree for a source file
	--   and efficiently update the syntax tree as the source file
	--   is edited.
	use("nvim-treesitter/nvim-treesitter", {
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/playground")
	use("p00f/nvim-ts-rainbow")
	use("andymass/vim-matchup")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
	use("nvim-lua/lsp_extensions.nvim")
	use("glepnir/lspsaga.nvim")
	use("simrat39/symbols-outline.nvim")
	use("j-hui/fidget.nvim", {
		config = require("fidget").setup(),
	}) -- Standalone UI for nvim-lsp progress

	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-nvim-lsp-document-symbol")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
	})
	use("ray-x/cmp-treesitter")
	use("rcarriga/cmp-dap")
	use("hrsh7th/cmp-nvim-lua")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("simrat39/rust-tools.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")

	-- MISC
	use("mbbill/undotree")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("numToStr/Comment.nvim", {
		config = require("Comment").setup(),
	})
	use("windwp/nvim-autopairs")
	use("sbdchd/neoformat", {
		config = function()
			vim.g.shfmt_opt = "-ci"
		end,
	})
	use("kyazdani42/nvim-tree.lua")
	use("ThePrimeagen/harpoon")
	use("akinsho/toggleterm.nvim")
	use("CRAG666/code_runner.nvim")
	use("dstein64/vim-startuptime")
	use("tpope/vim-fugitive")
	use("tanvirtin/vgit.nvim")
	use("lewis6991/impatient.nvim")
	use("farmergreg/vim-lastplace")
end)

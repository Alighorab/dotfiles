return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Color schemes and icons
	use("nvim-tree/nvim-web-devicons")
	use("lilydjwg/colorizer")
	use("EdenEast/nightfox.nvim")
	use("sainnhe/gruvbox-material")

	-- Nvim Treesitter configurations and abstraction layer
	-- Treesitter:
	--   An incremental parsing system for programming tools.
	--   It can build a concrete syntax tree for a source file
	--   and efficiently update the syntax tree as the source file
	--   is edited.
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("andymass/vim-matchup")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
	use("glepnir/lspsaga.nvim")
	use("j-hui/fidget.nvim", {
		config = require("fidget").setup(),
	})
	use("folke/trouble.nvim", {
		config = require("trouble").setup(),
	})
	use("simrat39/rust-tools.nvim")

	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("windwp/nvim-autopairs", {
		config = require("nvim-autopairs").setup({}),
	})

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("nvim-telescope/telescope-dap.nvim")

    -- Package manager
    use("williamboman/mason.nvim", {
        config = require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            -- The directory in which to install packages.
            install_root_dir = vim.fn.stdpath("data") .. "/mason",
        })
    })
    use("williamboman/mason-lspconfig.nvim")
    use("jayp0521/mason-nvim-dap.nvim")

	-- MISC
	use("mbbill/undotree")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("tpope/vim-fugitive")
	use("numToStr/Comment.nvim", {
		config = require("Comment").setup(),
	})
	use("sbdchd/neoformat", {
		config = function()
			vim.g.shfmt_opt = "-ci"
		end,
	})
	use("kyazdani42/nvim-tree.lua")
	use("nvim-lualine/lualine.nvim")
	use("ThePrimeagen/harpoon")
	use("akinsho/toggleterm.nvim")
	use("CRAG666/code_runner.nvim")
	use("dstein64/vim-startuptime")
	use("lewis6991/impatient.nvim")
	use("farmergreg/vim-lastplace")
	use("lewis6991/gitsigns.nvim", {
		config = require("gitsigns").setup(),
	})
    use("iamcco/markdown-preview.nvim")
	use("$HOME/plugins/winbar.nvim", {
		config = require("winbar").setup({}),
	})
	use("$HOME/plugins/markdown.nvim", {
		config = require("markdown").setup({
			browser = {
				command = "firefox",
				args = { "-P", "Markdown-Composer", "--class", "markdown" },
			},
		}),
	})
end)

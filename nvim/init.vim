" Improves the performance of startup time
lua _G.__luacache_config = { modpaths = { enable = false } } -- Don't miss up rtp
lua require("impatient")
" Trun syntax highlighting on
syntax on
" No compatiblity with vim
set nocompatible
" Enable nice window in EX mode
set wildmenu
" Make the cursor shape as block
set guicursor=
" OBVIOUS
set noerrorbells
" Set tab width
set tabstop=4 softtabstop=4
set shiftwidth=4 expandtab
set smartindent
" line and relativeline number
set nu relativenumber
" Works fantastic with undotree plugin
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" Move around buffers without saving
set hidden
" Don't wrap lines when it reached the border
set nowrap
" Remember not to excede 79 characters in one line!
set colorcolumn=80
" REMOVE highlighting after finishing the search command
set nohlsearch
" Show search matches while typing
set incsearch
" Set file encoding
set encoding=utf-8
" Show the commands on the right bottom of the editor
set showcmd
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8
" allow mouse support for all modes
set mouse=
" Enables 24-bit RGB color in the TUI
set termguicolors
" Don't show mode below
set noshowmode
" Enable filetype plugin, see :h filetype-plugin
filetype plugin on
" Map leader key to <space>
let mapleader = " "
" For CursorHold
set updatetime=300
" SignColumn
set signcolumn=yes

" vim-plug: A Minimalist Vim Plugin Manager
call plug#begin('~/.vim/plugged')

" Color schemes and icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'morhetz/gruvbox'
Plug 'lilydjwg/colorizer'

" Nvim Treesitter configurations and abstraction layer
" Treesitter:
"   An incremental parsing system for programming tools.
"   It can build a concrete syntax tree for a source file
"   and efficiently update the syntax tree as the source file
"   is edited.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'ray-x/cmp-treesitter'
Plug 'rcarriga/cmp-dap'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'simrat39/rust-tools.nvim'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

" MISC
Plug 'mbbill/undotree'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'numToStr/Comment.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ThePrimeagen/harpoon'
Plug 'akinsho/toggleterm.nvim'
Plug 'CRAG666/code_runner.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'kovetskiy/sxhkd-vim'
Plug 'fladson/vim-kitty'
Plug 'tpope/vim-fugitive'
Plug 'tanvirtin/vgit.nvim'

call plug#end()

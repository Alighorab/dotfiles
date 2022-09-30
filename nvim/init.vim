syntax on
" No compatiblity with vim
set nocompatible
" Enable nice window in EX mode
set wildmenu
" Use clipboard for ALL operations 
set clipboard=unnamedplus
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
" Allow mouse support for all modes
set mouse=a
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
" sxhkd config syntax highlighting
Plug 'kovetskiy/sxhkd-vim'
" kitty config syntax highlighting
Plug 'fladson/vim-kitty'

" Undotree
Plug 'mbbill/undotree'

" text objects
Plug 'michaeljsmith/vim-indent-object'

" Replace with register content
Plug 'vim-scripts/ReplaceWithRegister'

" tpope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

" Autoformatter
Plug 'sbdchd/neoformat'

" Nvimtree
Plug 'kyazdani42/nvim-tree.lua'

" Toggleterm
Plug 'akinsho/toggleterm.nvim'

" Harpoon
Plug 'ThePrimeagen/harpoon'

" Code Runner
Plug 'CRAG666/code_runner.nvim'

call plug#end()

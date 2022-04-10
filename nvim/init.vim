syntax on
set secure exrc
set nocompatible 
set path+=.,,**
set wildmenu
set clipboard=unnamedplus
set guicursor=
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu relativenumber
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set nowrap
set colorcolumn=80
set nohlsearch
set encoding=utf-8
set showcmd
set incsearch
set hidden
set scrolloff=8
set mouse=a
set termguicolors
set noshowmode
set signcolumn=no

au BufReadPost urxvtrc set syntax=xdefaults
au BufReadPost ~/.dotfiles/zsh/* set syntax=zsh
au BufReadPost ~/.scripts/* set syntax=sh
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.dotfiles/i3/config set filetype=i3config
aug end

call plug#begin('~/.vim/plugged')

" Color schemes and icons
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'noib3/nvim-cokeline'
Plug 'nvim-lualine/lualine.nvim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kovetskiy/sxhkd-vim'
Plug 'mboughaba/i3config.vim'
Plug 'fladson/vim-kitty'

" Undotree
Plug 'mbbill/undotree'

" text objects
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP, Completion, Snippts, and Auto-Pair
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Restores the cursor position and its autocmd.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Colorscheme
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

lua << END
require("Lualine")
require("Treesitter")
require("Cokeline")
require("Lsp")
END


" Remaps
let mapleader = " "

nnoremap <C-j> :bn<cr>
nnoremap <C-k> :bp<cr>
nnoremap <silent> <Tab> :bn<cr>
nnoremap <silent> <S-Tab> :bp<cr>
nnoremap Y y$
nnoremap <leader>a ggVG
inoremap <C-a> <esc>ggVG
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>d :bd!<CR>
" Line text object
xnoremap il g_o^
onoremap il :normal vil<cr>

" FZF
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>rg :Rg<cr>
nmap <leader>m :Marks<cr>
nmap <leader>t :Tags<cr>

" LSP, CMP, and Snippts
nmap <silent> <leader>gh <cmd>ClangdSwitchSourceHeader<CR>
nmap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> <leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nmap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nmap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nmap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nmap <silent> <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>
imap <C-j> <cmd>lua require'luasnip'.jump(1)<CR>
imap <C-k> <cmd>lua require'luasnip'.jump(-1)<CR>

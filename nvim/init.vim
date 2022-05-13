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

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.vim/plugged')

" Color schemes and icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'gruvbox-community/gruvbox'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kovetskiy/sxhkd-vim'
Plug 'mboughaba/i3config.vim'
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

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

" Markdown composer
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Toggleterm
Plug 'akinsho/toggleterm.nvim'

" Tabular
Plug 'godlygeek/tabular'

call plug#end()

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
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

" Markdown composer
let g:markdown_composer_browser='firefox --new-instance -P Markdown-Composer --class=markdown'

" Commentary
autocmd FileType c setlocal commentstring=//\ %s

lua << END
require("Lualine")
require("Treesitter")
require("Toggleterm")
END

let mapleader = " "

" Traverse buffers
nnoremap <silent> <C-j> :bnext<cr>
nnoremap <silent> <C-k> :bprevious<cr>
nnoremap <silent> <Tab> :bnext<cr>
nnoremap <silent> <S-Tab> :bprevious<cr>
" Delete buffer
nnoremap <silent> <leader>bd :bd!<CR>
" Yank to the end of line
nnoremap Y y$
" Moving lines
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
nnoremap <silent> <leader>j :m .+1<CR>==
nnoremap <silent> <leader>k :m .-2<CR>==
" Line text object
xnoremap il g_o^
onoremap il :normal vil<cr>
" Reselct pasted text
nnoremap gp `[v`]

" FZF
nmap <silent> <leader>ff :Files<cr>
nmap <silent> <leader>fb :Buffers<cr>
nmap <silent> <leader>rg :Rg<cr>
nmap <silent> <leader>fm :Marks<cr>
nmap <silent> <leader>ft :Tags<cr>

" LSP
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd FileType c nmap <silent> <leader>gh <cmd>CocCommand clangd.switchSourceHeader<CR>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gD <Plug>(coc-declaration)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>cl <Plug>(coc-codelens-action)

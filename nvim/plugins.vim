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

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" Color schemes and icons
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'luochen1990/rainbow'
Plug 'nvim-lualine/lualine.nvim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kovetskiy/sxhkd-vim'
Plug 'mboughaba/i3config.vim'
Plug 'fladson/vim-kitty'

" Undotree
Plug 'mbbill/undotree'

" Code screenshot
Plug 'jmckiern/vim-shoot', { 'do': '\"./install.py\" geckodriver' }

" Vim-surround
Plug 'tpope/vim-surround'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

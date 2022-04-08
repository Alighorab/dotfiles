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
au CursorHold * silent call CocActionAsync('highlight')

call plug#begin('~/.vim/plugged')

" Color schemes and icons
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'noib3/nvim-cokeline'
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

" tpope
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'vim-scripts/ReplaceWithRegister'
Plug 'michaeljsmith/vim-indent-object'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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

" COC-NVIM
let g:python3_host_prog='/usr/bin/python3'
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-clangd', 
  \ 'coc-html',
  \ 'coc-sh',
  \ ]

lua << END
-- Lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,

                shorting_target = 40,
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = '[+]',      -- Text to show when the file is modified.
                    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            }
        },
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
}

-- Cokeline
local get_hex = require('cokeline/utils').get_hex
require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
                if buffer.is_focused then
                    return "#000000"
                else 
                    return "Normal"
                end
            end,
        bg = function(buffer)
                if buffer.is_focused then
                    return "#a89984"
                else 
                    return "#3c3836"
                end
            end,
    },
    components = {
        { text = '', bg = get_hex('Normal', 'bg'), },
        { text = ' ', },
        { 
          text = function(buffer) return buffer.filename end,
          style = function(buffer)
            return buffer.is_focused and 'bold' or nil
          end,
        },
        { text = ' ', delete_buffer_on_left_click = false, },
    },
})

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
nnoremap <leader>bd :bd!<CR>
" Line text object
xnoremap il g_o^
onoremap il :normal vil<cr>

" COC-NVIM remaps
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>h :CocCommand clangd.switchSourceHeader<cr>
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" FZF
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>rg :Rg<cr>
nmap <leader>m :Marks<cr>
nmap <leader>t :Tags<cr>

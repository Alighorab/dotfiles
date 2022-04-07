source $XDG_CONFIG_HOME/nvim/plugins.vim
source $XDG_CONFIG_HOME/nvim/remaps.vim

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
set noshowmode

au BufReadPost urxvtrc set syntax=xdefaults
au BufReadPost ~/.dotfiles/zsh/* set syntax=zsh
au BufReadPost ~/.scripts/* set syntax=sh
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.dotfiles/i3/config set filetype=i3config
aug end

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
  \ 'coc-vimlsp'
  \ ]

autocmd CursorHold * silent call CocActionAsync('highlight')


" Lualine
lua << END
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'material',
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

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
}
END

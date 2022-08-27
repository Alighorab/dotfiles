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
filetype plugin on

au BufReadPost urxvtrc set syntax=xdefaults
au BufReadPost ~/.dotfiles/zsh/* set syntax=zsh
au BufReadPost ~/.scripts/* set syntax=sh
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.dotfiles/i3/config set filetype=i3config
aug end

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
augroup END

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
Plug 'morhetz/gruvbox'

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

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'normen/vim-pio'
Plug 'sbdchd/neoformat'

" Markdown composer
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Toggleterm
Plug 'akinsho/toggleterm.nvim'

" Tabular
Plug 'godlygeek/tabular'

" Harpoon
Plug 'ThePrimeagen/harpoon'

" Code Runner
Plug 'CRAG666/code_runner.nvim'

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

function! MultipleLineComment()
    :%s/\/\//\/\*/
    :%s/\(\/\*.*\)/\1 \*\//
endfunction

" Colorscheme
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

let b:copilot_enabled=1

" Markdown composer
let g:markdown_composer_browser='firefox --new-instance -P Markdown-Composer --class=markdown'
" Commentary
autocmd FileType c setlocal commentstring=//\ %s

lua << END

-- Lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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
        lualine_y = {'progress', 'location'},
        lualine_z = {"os.date('%I:%M %p')", 'data', "require'lsp-status'.status()"}
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

-- Toggleterm
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

-- Telescope
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}

-- Code Runner
require('code_runner').setup ({
    -- put here the commands by filetype
    filetype = {
        python = "python3 -u",
        c = "gcc -o $fileNameWithoutExt -O2 -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt",
        cpp = "g++ -o $fileNameWithoutExt -O2 -Wall $fileName; ./$fileNameWithoutExt; rm -f $fileNameWithoutExt"
    },
    mode = 'toggle',
    focus = true,
    smartinsert = true,
    float = {
        -- Window border (see ':h nvim_open_win')
        border = "solid",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
    },
})

END

let mapleader = " "

" Traverse buffers
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
" Change line comment to block comment in c
autocmd FileType c,cpp nnoremap <leader>cc :call MultipleLineComment()<cr><cr>
" Change function format to:
" return-type
" function name(parameters)
" {
"
" }
nmap <leader>fF 0f(bhxi<cr><esc>f{xo<esc>p
" Highlight current line
function! HighlightLine()
    " define line highlight color
    highlight LineHighlight guibg=#3c3836 guifg=bg
    call matchadd('LineHighlight', '\%'.line('.').'l')
endfunction

nnoremap <silent> <Leader>lh :call HighlightLine()<CR>
vnoremap <leader>lh :'<,'>call HighlightLine()<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>ch :call clearmatches()<CR>

" Code Runner
nnoremap <F9> <cmd>RunCode<CR>
nnoremap <F10> <cmd>RunClose<CR>
" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.8}})<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers({layout_strategy='vertical',layout_config={width=0.8}})<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags({layout_strategy='vertical',layout_config={width=0.8}})<cr>
nnoremap <leader>fs <cmd>Telescope treesitter<cr>
nnoremap <leader>fz <cmd>Telescope current_buffer_fuzzy_find<cr>

" Harpoon
nnoremap <leader>hr :lua require("harpoon.mark").add_file()<cr>
nnoremap <silent> <leader>fr :lua require("harpoon.ui").toggle_quick_menu()<cr>
nmap <A-1> <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nmap <A-2> <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nmap <A-3> <cmd>lua require("harpoon.ui").nav_file(3)<cr>
nmap <A-4> <cmd>lua require("harpoon.ui").nav_file(4)<cr>

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

autocmd FileType c,cpp nmap <silent> <leader>gh <cmd>CocCommand clangd.switchSourceHeader<CR>
autocmd FileType c nmap <leader>t <cmd>!ctags --kinds-c=f %<cr><cmd>Telescope tags<cr>
autocmd FileType c nmap <leader>T <cmd>!ctags --exclude=compile_commands.json --exclude=Makefile --kinds-c=f -R<cr><cmd>Telescope tags<cr>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gD <Plug>(coc-declaration)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>cd <cmd>CocDiagnostics<cr>
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <A-l> <cmd>wincmd l<cr>
nmap <A-h> <cmd>wincmd h<cr>
nmap <A-j> <cmd>wincmd j<cr>
nmap <A-k> <cmd>wincmd k<cr>

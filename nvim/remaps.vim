let mapleader = " "

" General remaps
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

inoremap <C-o> <esc>o

nnoremap Y y$

nnoremap <leader>a ggVG
inoremap <C-a> <esc>ggVG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>c :bw<CR>


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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" FZF
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>rg :Rg<cr>
nmap <leader>m :Marks<cr>
nmap <leader>t :Tags<cr>

nnoremap <silent> <Tab> :bnext<cr>
nnoremap <silent> <S-Tab> :bprevious<cr>
nnoremap <silent> <leader>bd :bd!<CR>
nnoremap Y y$
" The best remaps ever!
" Move lines very quickly
" :[range]move {address}
"   Move the lines given by [range] to below the line
"   given by {address}.
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
nnoremap <silent> <leader>j :m .+1<CR>==
nnoremap <silent> <leader>k :m .-2<CR>==
" Line text object
xnoremap il g_o^
onoremap il :normal vil<cr>
" Reselct pasted text
nnoremap gp `[v`]
" Copying and pasting from clipboard
nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

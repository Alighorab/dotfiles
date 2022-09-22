" COC extentions
let g:coc_global_extensions = [ 
            \ 'coc-json',
            \ 'coc-clangd',
            \ 'coc-snippets',
            \ 'coc-go',
            \ 'coc-pairs',
            \ 'coc-vimlsp',
            \ 'coc-tag',
            \ 'coc-html',
            \ 'coc-sh',
            \ '@yaegassy/coc-pylsp' 
            \ ]

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gD <Plug>(coc-declaration)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>cd <cmd>CocDiagnostics<cr>
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

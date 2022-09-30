" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

vnoremap <leader>fm :'<,'>!fmt -w 79<CR>
nnoremap <leader>ht :!grip --export %<CR><CR>

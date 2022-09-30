" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal cindent
nmap <silent> <leader>gh <cmd>CocCommand clangd.switchSourceHeader<CR>

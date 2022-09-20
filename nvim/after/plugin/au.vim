" Set clang-format config filetype
au BufReadPost .clang-format set filetype=yaml

" Highlight yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
augroup END

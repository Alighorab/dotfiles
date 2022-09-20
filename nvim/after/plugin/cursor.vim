" Restores the cursor position and its autocmd.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

" Restores the cursor position and its autocmd.
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

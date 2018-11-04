augroup config#completion
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

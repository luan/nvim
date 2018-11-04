augroup config#completion
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

call ncm2#override_source('bufword', {'on_completed': 0})

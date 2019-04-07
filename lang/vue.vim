augroup config#vue
  autocmd!
  autocmd BufWritePost *.vue syntax sync fromstart
  autocmd BufReadPost *.vue syntax sync fromstart
  autocmd FileType vue syntax sync fromstart
  autocmd BufEnter *.vue set filetype=vue
augroup END
let g:vue_disable_pre_processors = 1


let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

let g:formatters_javascript = ['eslint_local']
let g:formatters_vue = ['eslint_local']

augroup config#autoformat
  autocmd!
  " Autoformat on save
  autocmd BufWrite *.c,*.h,*.cpp,*.hpp :Autoformat
  autocmd BufWrite *.go :Autoformat
  autocmd BufWrite *.js :Autoformat
  autocmd BufWrite *.vue :Autoformat
  autocmd BufWrite *.rs :Autoformat
augroup END

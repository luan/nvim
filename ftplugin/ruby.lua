vim.cmd [[
augroup config#ruby
  autocmd!
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline re=1 foldmethod=syntax
augroup END
]]
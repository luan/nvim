augroup config#ruby
  autocmd!
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline re=1 foldmethod=syntax
augroup END

if !executable('solargraph') && executable('gem')
  call jobstart('gem install solargraph')
endif
call lspex#add_server('ruby', ['solargraph', 'stdio'])

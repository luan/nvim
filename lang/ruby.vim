augroup config#ruby
  autocmd!
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline re=1 foldmethod=syntax
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
augroup END

if !executable('solargraph') && executable('gem')
  call jobstart('gem install solargraph')
endif

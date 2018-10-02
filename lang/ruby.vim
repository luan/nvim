augroup config#ruby
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline re=1 foldmethod=syntax

  if executable('solargraph')
    " gem install solargraph
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'solargraph',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
          \ 'initialization_options': {"diagnostics": "true"},
          \ 'whitelist': ['ruby'],
          \ })
  endif
augroup END


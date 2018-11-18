function! lsp#add_server(language, cmd)
  if !exists('g:LanguageClient_serverCommands')
    let g:LanguageClient_serverCommands = {}
  endif
  let g:LanguageClient_serverCommands[a:language] = a:cmd
endfunction


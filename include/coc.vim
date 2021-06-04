let g:coc_global_extensions = [
      \   'coc-css',
      \   'coc-emmet',
      \   'coc-go',
      \   'coc-highlight',
      \   'coc-html',
      \   'coc-json',
      \   'coc-pyright',
      \   'coc-rust-analyzer',
      \   'coc-rls',
      \   'coc-snippets',
      \   'coc-solargraph',
      \   'coc-tsserver',
      \   'coc-yaml',
      \ ]

autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)


augroup config#go#coc
  autocmd!
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

let s:languageserver = {}

if executable('ccls')
  let s:languageserver["ccls"] = {
        \   "command": "ccls",
        \   "filetypes": ["c", "cpp", "objc", "objcpp"],
        \   "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/"],
        \   "initializationOptions": {
        \     "cache": {
        \       "directory": "/tmp/ccls"
        \     }
        \   }
        \ }
endif

if executable('bash-language-server')
  let s:languageserver["bash"] = {
        \   "command": "bash-language-server",
        \   "args": ["start"],
        \   "filetypes": ["sh"],
        \   "ignoredRootPaths": ["~"]
        \ }
endif

call coc#config('languageserver', s:languageserver)

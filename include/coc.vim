if !executable('yarn')
  finish
endif

let g:coc_global_extensions = [
      \   'coc-css',
      \   'coc-emmet',
      \   'coc-highlight',
      \   'coc-html',
      \   'coc-json',
      \   'coc-python',
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

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

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

if executable('gopls')
  let s:languageserver["golang"] = {
        \   "command": "gopls",
        \   "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
        \   "filetypes": ["go"],
        \   "initializationOptions": {
        \     "completeUnimported": v:true,
        \     "deepCompletion": v:true,
        \     "fuzzyMatching": v:true,
        \     "usePlaceholders": v:true
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

if executable('python')
  let s:languageserver["python"] = {
        \   "command": "python",
        \   "args": [
        \     "-mpyls",
        \     "-vv",
        \     "--log-file",
        \     "/tmp/lsp_python.log"
        \   ],
        \   "trace.server": "verbose",
        \   "filetypes": ["python"],
        \   "settings": {
        \     "pyls": {
        \       "enable": v:true,
        \       "trace": {
        \         "server": "verbose"
        \       },
        \       "commandPath": "",
        \       "configurationSources": [
        \         "pycodestyle"
        \       ],
        \       "plugins": {
        \         "jedi_completion": {
        \           "enabled": v:true
        \         },
        \         "jedi_hover": {
        \           "enabled": v:true
        \         },
        \         "jedi_references": {
        \           "enabled": v:true
        \         },
        \         "jedi_signature_help": {
        \           "enabled": v:true
        \         },
        \         "jedi_symbols": {
        \           "enabled": v:true,
        \           "all_scopes": v:true
        \         },
        \         "mccabe": {
        \           "enabled": v:true,
        \           "threshold": 15
        \         },
        \         "preload": {
        \           "enabled": v:true
        \         },
        \         "pycodestyle": {
        \           "enabled": v:true
        \         },
        \         "pydocstyle": {
        \           "enabled": v:false,
        \           "match": "(?!test_).*\\.py",
        \           "matchDir": "[^\\.].*"
        \         },
        \         "pyflakes": {
        \           "enabled": v:true
        \         },
        \         "rope_completion": {
        \           "enabled": v:true
        \         },
        \         "yapf": {
        \           "enabled": v:true
        \         }
        \       }
        \     }
        \   }
        \ }
endif

call coc#config('languageserver', s:languageserver)

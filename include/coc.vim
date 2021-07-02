let g:coc_global_extensions = [
      \   'coc-css',
      \   'coc-emmet',
      \   'coc-go',
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

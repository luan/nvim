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

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" This is noise as heck: see https://github.com/neoclide/coc.nvim/issues/888
autocmd BufWritePre *.go :OR

let s:languageserver = {}

call coc#config('coc.preferences.formatOnSaveFiletypes', [ "go", "json", "c", "cpp", "javascript", "typescript"])
call coc#config('yaml.validate', 0)

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
        \   "filetypes": ["go"]
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

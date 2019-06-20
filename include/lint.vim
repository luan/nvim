scriptencoding utf-8

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '➟'

if has('nvim-0.3.2')
  let g:ale_echo_cursor = 1
  let g:ale_virtualtext_cursor = 0
  let g:ale_virtualtext_prefix = '▬▶  '

  highlight link ALEVirtualTextError ErrorMsg
  highlight link ALEVirtualTextStyleError ALEVirtualTextError
  highlight link ALEVirtualTextWarning WarningMsg
  highlight link ALEVirtualTextInfo ALEVirtualTextWarning
  highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning
endif

let g:ale_go_langserver_executable = 'gopls'

let g:ale_linters = {
\   'go': ['go build', 'gofmt', 'golangci-lint', 'gopls'],
\   'typescript': ['tsserver', 'typecheck'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop', 'ruby'],
\}

" This gets around typecheck errors for types defined in other files in the
" same package
let g:ale_go_golangci_lint_package = 1
if filereadable('.golangci.json')
  let g:ale_go_golangci_lint_options = ''
endif

" Enable completion where available.
let g:ale_completion_enabled = 0

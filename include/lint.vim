scriptencoding utf-8

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '➟'

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '▬▶  '

let g:ale_hover_cursor = 0
let g:ale_echo_cursor = 1
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_set_loclist = 0

highlight link ALEVirtualTextError ErrorMsg
highlight link ALEVirtualTextStyleError ALEVirtualTextError
highlight link ALEVirtualTextWarning WarningMsg
highlight link ALEVirtualTextInfo ALEVirtualTextWarning
highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning

let g:ale_linters = {
\   'go': ['golangci-lint'],
\   'typescript': ['typecheck'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop', 'ruby'],
\   'proto': [],
\}

" This gets around typecheck errors for types defined in other files in the
" same package
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'

" Enable completion where available.
let g:ale_completion_enabled = 0

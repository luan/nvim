scriptencoding utf-8

nmap <silent> <M-n> <Plug>(ale_previous_wrap)
nmap <silent> <M-p> <Plug>(ale_next_wrap)

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '➟'
let g:ale_sign_column_always = 1

let g:ale_linters = {
\   'go': ['go build', 'gofmt', 'gometalinter'],
\   'typescript': ['tsserver', 'typecheck'],
\   'javascript': ['eslint'],
\}

" Enable completion where available.
let g:ale_completion_enabled = 1


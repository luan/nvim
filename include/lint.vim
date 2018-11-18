scriptencoding utf-8

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '➟'

if has('nvim-0.3.2')
  try
    silent! call ale#virtualtext#Clear()
    if exists('*ale#virtualtext#Clear')
      let g:ale_echo_cursor = 0
      let g:ale_virtualtext_cursor = 1
      let g:ale_virtualtext_prefix = '▬▶  '
      let g:ale_set_balloons = 1

      highlight link ALEVirtualTextError ErrorMsg
      highlight link ALEVirtualTextStyleError ALEVirtualTextError
      highlight link ALEVirtualTextWarning WarningMsg
      highlight link ALEVirtualTextInfo ALEVirtualTextWarning
      highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning
    endif
  endtry
endif

let g:ale_linters = {
\   'go': ['go build', 'gofmt', 'gometalinter'],
\   'typescript': ['tsserver', 'typecheck'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop', 'ruby'],
\}

" Enable completion where available.
let g:ale_completion_enabled = 0

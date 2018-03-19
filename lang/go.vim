let g:go_fmt_autosave = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_experimental = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

let g:go_snippet_engine = 'ultisnips'

let g:go_bin_path = $HOME . '/.local/share/nvim/go/bin'
let $PATH .= ':' . g:go_bin_path

let g:go_auto_type_info = 0

let g:ale_go_gometalinter_options =
      \ '--tests ' .
      \ '--fast ' .
      \ '--disable=gotype ' .
      \ '--disable=gotypex ' .
      \ '--exclude="should have comment" ' .
      \ '--exclude="error return value not checked \(defer"'

augroup config#go
  autocmd!
  autocmd Filetype go
        \ command! -bang A call go#alternate#Switch(<bang>0, 'edit') |
        \ command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit') |
        \ command! -bang AS call go#alternate#Switch(<bang>0, 'split') |
        \ compiler go
  autocmd! BufEnter *.go
        \ setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
augroup END


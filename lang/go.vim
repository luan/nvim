let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_metalinter_autosave = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 0
let g:go_fmt_experimental = 1

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

let g:go_list_type = 'quickfix'

let g:go_snippet_engine = 'ultisnips'

let g:go_bin_path = $HOME . '/.local/share/nvim/go/bin'
let $PATH = $PATH . ':' . g:go_bin_path
call mkdir(g:go_bin_path, 'p', 0755)

let g:go_auto_type_info = 0
let g:go_code_completion_enabled = 0

let g:ale_go_gometalinter_options =
      \ '--tests ' .
      \ '--fast ' .
      \ '--disable=gotype ' .
      \ '--disable=gotypex ' .
      \ '--exclude="should have comment" ' .
      \ '--exclude="error return value not checked \(defer"'

let s:projections = {
      \ '*.go': {'type': 'go', 'alternate': '{}_test.go'},
      \ '*_test.go': {'type': 'go', 'alternate': '{}.go'},
      \ }

function! s:ProjectionistDetect() abort
  if &filetype ==# 'go'
    let l:projections = deepcopy(s:projections)
    call projectionist#append(getcwd(), l:projections)
  endif
endfunction

augroup config#go
  autocmd!
  autocmd User ProjectionistDetect call s:ProjectionistDetect()
augroup END

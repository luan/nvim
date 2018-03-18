let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

let s:crmap = 0

function! Multiple_cursors_before()
  let s:crmap = maparg('<CR>', 'n')
  unmap! <expr> <CR>
endfunction

function! Multiple_cursors_after()
  unmap! <expr> <CR>
  exec 'nnoremap <expr> <CR> ' . s:crmap
endfunction

highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual


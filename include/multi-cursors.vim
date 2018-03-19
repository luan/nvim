let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

function! Multiple_cursors_before()
  silent! unmap <expr> <CR>
endfunction

function! Multiple_cursors_after()
  silent! nnoremap <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'
endfunction

augroup config#multi-cursors
  autocmd!
  autocmd ColorScheme *
   \   highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
   \ | highlight link multiple_cursors_visual Visual
augroup END


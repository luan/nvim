function! Multiple_cursors_before()
  call ncm2#disable_for_buffer()
  silent! noremap <buffer> <CR> <CR>
endfunction

function! Multiple_cursors_after()
  call ncm2#enable_for_buffer()
  silent! unmap <buffer> <CR>
endfunction

augroup config#multi-cursors
  autocmd!
  autocmd ColorScheme *
   \   highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
   \ | highlight link multiple_cursors_visual Visual
augroup END

let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'

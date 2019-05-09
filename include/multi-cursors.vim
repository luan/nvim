function! Multiple_cursors_before()
  silent! noremap <buffer> <CR> <CR>
  silent! vnoremap <buffer> <Space> <nop>
  silent! nnoremap <buffer> <Space> <nop>
endfunction

function! Multiple_cursors_after()
  silent! unmap <buffer> <CR>
  silent! vunmap <buffer> <Space>
  silent! nunmap <buffer> <Space>
endfunction

augroup config#multi-cursors
  autocmd!
  autocmd ColorScheme *
   \   highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
   \ | highlight link multiple_cursors_visual Visual
augroup END

let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'

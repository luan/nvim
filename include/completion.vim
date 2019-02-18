let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])

function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

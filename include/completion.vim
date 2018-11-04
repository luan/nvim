augroup config#completion
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

inoremap <silent> <expr> <c-j> ncm2_ultisnips#expand_or("\<CR>", 'n')


augroup Mkdir
  autocmd!
  autocmd BufWritePre *
        \ if !isdirectory(expand("<afile>:p:h")) |
        \   call mkdir(expand("<afile>:p:h"), "p") |
        \ endif
augroup END

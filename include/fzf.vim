if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

command! -bang -nargs=* FZFRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
      \      . shellescape(<q-args>), 1, <bang>0
      \ )

augroup config#fzf
  autocmd!
  autocmd FileType fzf set laststatus=0 noruler
        \| autocmd BufLeave <buffer> set laststatus=2 ruler
augroup END


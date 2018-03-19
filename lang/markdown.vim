augroup config#markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md setlocal spell linebreak nonumber textwidth=80
augroup END

let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'vim', 'go', 'ruby', 'python', 'bash=sh']


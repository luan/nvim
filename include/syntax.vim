fun! GetSyntaxGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" SyntaxGroup: print the syntax highlight group of the element under the cursor
command! SyntaxGroup call GetSyntaxGroup()

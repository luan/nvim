" UltiSnips
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-f>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'

" ALE
nmap <silent> <M-n> <Plug>(ale_previous_wrap)
nmap <silent> <M-p> <Plug>(ale_next_wrap)

" Eanble completion with tab/shift-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Extra commentary mappings
xmap <c-_>  <Plug>Commentary
omap <c-_>  <Plug>Commentary
nmap <c-_>  <Plug>CommentaryLine

" Save with enter
nnoremap <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'

" Close and delete buffer
nnoremap <silent> <M-q> :Sayonara<cr>

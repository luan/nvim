let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsMoveCharacter = ''
let g:AutoPairsMapCR = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsOnlyAtEOL = 1
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

augroup config#autopairs
  autocmd!
  autocmd BufEnter *
        \ inoremap <script> <buffer> <silent> <CR> <CR><C-R>=AutoPairsReturn()<CR>
augroup END


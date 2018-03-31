let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsMoveCharacter = ''
let g:AutoPairsMapCR = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose=0
let g:AutoPairsOnlyBeforeClose=1
let g:AutoPairsBalanceImmediately=1
let g:AutoPairsNeverJumpLines=1

let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`'}

function! s:ExpandMap(map)
  let l:map = a:map
  let l:map = substitute(l:map, '\(<Plug>\w\+\)', '\=maparg(submatch(1), "i")', 'g')
  return l:map
endfunction

function! AutoPairsMapCR()
  if exists('b:autopairs_loaded')
    return
  end

  let l:info = maparg('<CR>', 'i', 0, 1)
  if empty(l:info)
    let l:old_cr = '<CR>'
    let l:is_expr = 0
  else
    let l:old_cr = l:info['rhs']
    let l:old_cr = s:ExpandMap(l:old_cr)
    let l:old_cr = substitute(l:old_cr, '<SID>', '<SNR>' . l:info['sid'] . '_', 'g')
    let l:is_expr = l:info['expr']
    let l:wrapper_name = '<SID>AutoPairsOldCRWrapper73'
  endif

  if l:old_cr !~? 'AutoPairsReturn'
    if l:is_expr
      " remap <expr> to `name` to avoid mix expr and non-expr mode
      execute 'inoremap <buffer> <expr> <script> '. l:wrapper_name . ' ' . l:old_cr
      let l:old_cr = l:wrapper_name
    end
    " Always silent mapping
    execute 'inoremap <script> <buffer> <silent> <CR> ' . l:old_cr . '<C-R>=AutoPairsReturn()<CR>'
  end
endfunction

augroup config#autopairs
  autocmd!
  autocmd BufEnter *
        \ call AutoPairsMapCR()
augroup END


" Replace in visual mode without copying
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Replace()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Replace()


function! s:goyo_enter()
  silent !i3-msg fullscreen || true
  silent !tmux set status off || true
  silent !tmux list-panes -F \#F | grep -q Z || tmux resize-pane -Z || true
  set noshowcmd
  set scrolloff=999
  set nolazyredraw
  execute 'GitGutterDisable'
  execute 'Limelight'
endfunction

function! s:goyo_leave()
  silent !i3-msg fullscreen || true
  silent !tmux set status on || true
  silent !tmux list-panes -F \#F | grep -q Z && tmux resize-pane -Z || true
  set showcmd
  set scrolloff=5
  execute 'GitGutterEnable'
  execute ':Limelight!'
endfunction

let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1

augroup config#goyo
  autocmd!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  autocmd! VimResized * if exists('#goyo') | exe "normal \<c-w>=" | redraw! | endif
augroup END

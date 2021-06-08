let s:focus_mode = 0

fun! FocusMode()
  if s:focus_mode == 0
    let s:focus_mode = 1
    :SignatureToggleSigns
    :IndentBlanklineDisable!
    set nonumber
    let g:SignatureEnabledAtStartup = 0
    let g:gitgutter_signs = 0

    augroup focus#mode
      autocmd!
      autocmd VimEnter * GitGutterDisable
    augroup end
  else
    let s:focus_mode = 0
    :SignatureToggleSigns
    :IndentBlanklineEnable!
    set number
    let g:SignatureEnabledAtStartup = 1
    let g:gitgutter_signs = 1

    augroup focus#mode
      autocmd!
    augroup end
  endif
endfun

" FocusMode: Focus-mode: remove gutter info for a cleaner experience
command! FocusMode call FocusMode()

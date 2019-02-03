let s:is_win = has('win32') || has('win64')
let s:dir = fnamemodify(expand('$MYVIMRC'), ':p:h')
let s:update_timer_file = '/tmp/luan_vim_update_timer'

function! s:chsh()
  let l:prev = [&shell, &shellcmdflag, &shellredir]
  set shell=sh shellredir=>%s\ 2>&1
  return l:prev
endfunction

function! s:jobstart(cmd, options)
  try
    let [l:sh, l:shellcmdflag, l:shrd] = s:chsh()
    let l:cmd = printf('cd %s && %s', shellescape(s:dir), a:cmd)
    return jobstart(l:cmd, a:options)
  finally
    let [&shell, &shellcmdflag, &shellredir] = [l:sh, l:shellcmdflag, l:shrd]
  endtry
endfunction

function! s:system(cmd)
  try
    let [l:sh, l:shellcmdflag, l:shrd] = s:chsh()
    let l:cmd = printf('cd %s && %s', shellescape(s:dir), a:cmd)
    return system(l:cmd)
  finally
    let [&shell, &shellcmdflag, &shellredir] = [l:sh, l:shellcmdflag, l:shrd]
  endtry
endfunction

function! update#localVersion()
  return s:system('git rev-parse @')
endfunction

function! update#remoteVersion()
  return s:system('git rev-parse "@{u}"')
endfunction

function! update#autoUpdateEnabled()
  return !exists('g:skip_autoupdate') || g:skip_autoupdate != 1
endfunction

function! s:remote_updated(...)
  let l:local = update#localVersion()
  let l:remote = update#remoteVersion()
  let l:base = s:system('git merge-base @ "@{u}"')

  if l:local == l:remote
    call writefile([''], s:update_timer_file)
    echohl WarningMsg | echomsg 'Vim distribution is up-to-date.' | echohl None
  elseif l:local == l:base
    call s:system('git merge ' . l:remote)
    call writefile([''], s:update_timer_file)

    let g:update_plugins = 1
    runtime plug.vim
    echohl ErrorMsg | echomsg 'Nvim config has been updated. Please re-open Nvim to apply changes.' | echohl None
  elseif l:remote == l:base
    echoerr 'Local commits detected. You may want to push / send a PR / move your'
    \ 'changes to user settings?'
  else
    echoerr 'Local changes detected. If these are user preferences, consider'
    \ 'moving them to your user settings.'
  endif
endfunction

function! s:update()
  echohl Special | echomsg 'Updating nvim config...' | echohl None
  let l:update_job = s:jobstart('git remote update', {
        \ 'on_exit': function('s:remote_updated')
        \ })
endfunction

function! update#lastchecked()
  return getftime(s:update_timer_file)
endfunction

if s:is_win || !update#autoUpdateEnabled()
  finish
endif

if update#lastchecked() > (localtime() - 60 * 60 * 24)
  " We checked update on this boot cycle and in the last 24 hours, skip
  finish
end

autocmd VimEnter * call s:update()

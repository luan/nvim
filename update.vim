let s:is_win = has('win32') || has('win64')
if s:is_win || exists('g:skip_autoupdate')
  finish
endif
let g:skip_autoupdate = 1
let s:dir = fnamemodify(expand('$MYVIMRC'), ':p:h')
let s:update_timer_file = '/tmp/luan_vim_update_timer'

if getftime(s:update_timer_file) > (localtime() - 60 * 60 * 24)
  " We checked update on this boot cycle and in the last 24 hours, skip
  finish
end

function! s:chsh()
  let l:prev = [&shell, &shellcmdflag, &shellredir]
  set shell=sh shellredir=>%s\ 2>&1
  return l:prev
endfunction

function! s:jobstart(cmd)
  try
    let [l:sh, l:shellcmdflag, l:shrd] = s:chsh()
    let l:cmd = printf('cd %s && %s', shellescape(s:dir), a:cmd)
    return jobstart(l:cmd)
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

function! s:update()
  let l:update_job = s:jobstart('git remote update')
  if jobwait([l:update_job], 5000)[0] != 0
    echoerr 'Timed out updating vim distribution. Check your internet connection.'
	  \ '(Vim will start normally with previous configuration)'
    return
  endif

  let l:local = s:system('git rev-parse @')
  let l:remote = s:system('git rev-parse "@{u}"')
  let l:base = s:system('git merge-base @ "@{u}"')

  if l:local == l:remote
    call writefile([''], s:update_timer_file)
    silent! echom 'Vim distribution is up-to-date.'
  elseif l:local == l:base
    call s:system('git merge ' . l:remote)
    call writefile([''], s:update_timer_file)
  elseif l:remote == l:base
    echom 'Local commits detected. You may want to push / send a PR / move your'
	  \ 'changes to user settings?'
  else
    echom 'Local changes detected. If these are user preferences, consider'
	  \ 'moving them to your user settings.'
  endif
endfunction

call s:update()

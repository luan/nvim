let s:is_win = has('win32') || has('win64')
let s:dir = fnamemodify(expand('$MYVIMRC'), ':p:h')

function! s:missingDependency(command)
  if !executable(a:command)
    echohl WarningMsg
    echomsg 'nvim config dependency `' . a:command . '` not installed and is requred.'
    echohl None
    return 1
  endif
  return 0
endfunction

function! s:checkDependencies()
  if s:missingDependency('curl') ||
        \ s:missingDependency('npm') ||
        \ s:missingDependency('yarn')
    echoerr 'Missing dependencies detected. Please refer to the README for more information on how to install them.'
  endif
endfunction

call s:checkDependencies()

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

function! update#installLanguageServers()
  if executable('gem')
    call jobstart('gem install solargraph')
  endif

  if executable('npm')
    call jobstart('npm i -g bash-language-server')
  endif

  if executable('rustup')
    call jobstart('rustup component add rls rust-analysis rust-src')
  endif
endfunction

function! s:remote_updated(id, status, type)
  if a:status != 0
    echohl ErrorMsg | echomsg 'Error fetching remote Nvim config. Are you connected to the internet?' | echohl None
    return
  endif

  call s:system('git update-index -q --refresh')
  call s:system('git diff-index --quiet HEAD --')

  let l:has_local_changes = v:shell_error
  let l:local = update#localVersion()
  let l:remote = update#remoteVersion()
  let l:base = s:system('git merge-base @ "@{u}"')

  if l:has_local_changes
    echoerr 'Local changes detected. If these are user preferences, consider'
    \ 'moving them to your user settings.'
  elseif l:local == l:remote
    return
  elseif l:local == l:base
    call s:system('git merge ' . l:remote)

    " should probably figure out a better way to do this
    call update#installLanguageServers()

    let g:update_plugins = 1
    runtime plug.vim
    echohl WarningMsg | echomsg 'Nvim config has been updated. Please re-open Nvim to apply changes.' | echohl None
  elseif l:remote == l:base
    echoerr 'Local commits detected. You may want to push / send a PR / move your'
    \ 'changes to user settings?'
  endif
endfunction

function! s:update()
  let l:update_job = s:jobstart('git remote update', {
        \ 'on_exit': function('s:remote_updated')
        \ })
endfunction

if s:is_win || !update#autoUpdateEnabled()
  finish
endif

autocmd VimEnter * call s:update()

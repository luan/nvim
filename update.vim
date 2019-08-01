let s:is_win = has('win32') || has('win64')
let s:dir = fnamemodify(expand('$MYVIMRC'), ':p:h')

function! s:missingDependency(command)
  if !executable(a:command)
    echohl WarningMsg
    echomsg 'nvim config dependency `' . a:command . '` not installed and is required.'
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

function! update#status()
  if update#localVersion() != update#remoteVersion()
    return " update available!"
  endif

  return ""
endfunction

function! update#localVersion()
  return s:system('git rev-parse @')
endfunction

function! update#remoteVersion()
  return s:system('git rev-parse "@{u}"')
endfunction

function! update#installLanguageServers()
  echo 'Installing language servers...'
  if executable('gem')
    echo 'Installing solargraph [ruby]...'
    call s:system('gem install solargraph')
    echon ' Done.'
  endif

  if executable('npm')
    echo 'Installing bash-language-server [bash]...'
    call s:system('npm i -g bash-language-server')
    echon ' Done.'
  endif

  if executable('rustup')
    echo 'Installing rls [rust]...'
    call s:system('rustup component add rls rust-analysis rust-src')
    echon ' Done.'
  endif
endfunction

function! s:update_hook(force)
  let g:update_plugins = 1
  runtime plug.vim
  call update#installLanguageServers()
  if executable('go')
    if a:force ==# 1
      GoUpdateBinaries
    else
      GoInstallBinaries
    endif
  endif
  echohl WarningMsg | echomsg 'Nvim config has been updated. Please re-open Nvim to apply changes.' | echohl None
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
    echohl WarningMsg | echomsg 'Local changes detected. If these are user preferences, consider'
    \ 'moving them to your user settings.' | echohl None
  elseif l:local == l:remote
    return
  elseif l:local == l:base
    echohl WarningMsg | echomsg 'There is a new version of the nvim config available. Run :ConfigUpdate to update to the latest.' | echohl None
  elseif l:remote == l:base
    echohl WarningMsg | echomsg 'Local commits detected. You may want to push / send a PR / move your'
          \ 'changes to user settings?' | echohl None
  endif
endfunction

function! s:update(force)
  call s:system('git update-index -q --refresh')
  call s:system('git diff-index --quiet HEAD --')

  let l:has_local_changes = v:shell_error
  let l:local = update#localVersion()
  let l:remote = update#remoteVersion()
  let l:base = s:system('git merge-base @ "@{u}"')

  if l:has_local_changes
    echohl ErrorMsg | echomsg 'Local changes detected. Update aborted!' | echohl None
    return
  elseif l:local == l:remote
    return
  elseif l:local == l:base
    call s:system('git merge ' . l:remote)
  elseif l:remote == l:base
    echohl ErrorMsg | echomsg 'Local commits detected. Update aborted!' | echohl None
    return
  endif

  call s:update_hook(a:force)
endfunction

function! s:checkupdates(timerid)
  let l:update_job = s:jobstart('git remote update', {
        \ 'on_exit': function('s:remote_updated')
        \ })
endfunction

command! ConfigInstallLanguageServers call update#installLanguageServers()
command! -bang ConfigUpdate call s:update(<bang>0)

" every hour, check for updates
let s:timer = timer_start(3600 * 1000, funcref("<sid>checkupdates"), { 'repeat': -1 })
autocmd VimEnter * :call s:checkupdates(0) " check once on load

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" Color schemes {
Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'
Plug 'kadekillary/Turtles'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
" }

" Language configuration {
" C {
Plug 'arakashic/chromatica.nvim'
" }

" Ruby {
Plug 'keith/rspec.vim'
Plug 'tpope/vim-bundler', { 'for': ['ruby', 'rake'] }
Plug 'tpope/vim-cucumber', { 'for': ['cucumber'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'rake'] }
Plug 'tpope/vim-rake', { 'for': ['ruby', 'rake'] }
" }

" Python {
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" }

" Markdown {
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
" }

" JavaScript {
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'maxmellon/vim-jsx-pretty'
" }

" TypeScript {
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" }

" Vue {
Plug 'posva/vim-vue', { 'for': 'vue' }
" }

" CSS / HTML {
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'gregsexton/MatchTag'
Plug 'iloginow/vim-stylus'
" }

" Elm {
Plug 'elmcast/elm-vim', { 'for': 'elm' }
" }

" Rust {
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" }

" Org Mode {
Plug 'jceb/vim-orgmode'
" }

" Starlark {
Plug 'cappyzawa/starlark.vim'
" }

" Misc {
Plug 'PProvost/vim-ps1'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'chr4/nginx.vim'
Plug 'dag/vim-fish'
Plug 'hashivim/vim-terraform'
Plug 'keith/tmux.vim'
Plug 'kurayama/systemd-vim-syntax'
Plug 'peterhoeg/vim-qml'
Plug 'uarun/vim-protobuf'
Plug 'junegunn/vader.vim'
" }
" }

" Load user plugins
runtime! user/plug.vim

call plug#end()

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  PlugInstall --sync | q
elseif exists('g:update_plugins') && g:update_plugins
  echo 'Updating plugins...'
  PlugUpdate --sync | q
endif

function! plug#reset_all_plugins(confirm)
  if a:confirm ==# 1
    call system('rm -rf ~/.local/share/nvim/plugged')
  else
    echoerr 'Refusing to delete plugins with confirmation, re-run the command with !'
  endif
endfunction

command! -bang ConfigResetAllPluginsReallyDoIt call plug#reset_all_plugins(<bang>0)

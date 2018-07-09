if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

function! ConfigUpdated(info)
  echom 'Neovim config updated! Restart Neovim to ensure you are running all the latest.'
endfunction
" Plug can manage this config but we don't need it to load it
Plug 'luan/nvim', { 'as': 'distribution', 'dir': $HOME . '/.config/nvim', 'do': function('ConfigUpdated') }

" Color schemes {
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'
" }

" UI -- User interface additions {
" Fancy start page with recent files, etc
Plug 'mhinz/vim-startify'

" Show trailing whitespace in red
Plug 'bronson/vim-trailing-whitespace'

" Plugin to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Lightweight status line
Plug 'itchyny/lightline.vim'

" Visual guide for keybindings
Plug 'hecal3/vim-leader-guide'
" }

" Editing -- Text manipulation helpers {
" (Un-)comment code
Plug 'tpope/vim-commentary'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Visual context when bulk editing buffers
Plug 'pelodelfuego/vim-swoop'

" Select regions incrementally
Plug 'terryma/vim-expand-region'

" Automatically close pairs such as () or []
Plug 'dropofwill/auto-pairs'

" Automatically add 'end' when opening a block
Plug 'tpope/vim-endwise'

" Move parameters around (delimited by a separator such as ,)
Plug 'machakann/vim-swap'

" Simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" :Join command
Plug 'sk1418/Join'

" quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens
Plug 'tpope/vim-surround'

" enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

" Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.
Plug 'maxbrunsfeld/vim-emacs-bindings'

" Plugin to move lines and selections up and down
Plug 'matze/vim-move'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'tpope/vim-speeddating'

" Easy text exchange operator for Vim
Plug 'tommcdo/vim-exchange'
" }

" General -- Helpful generic tools with no dependencies {
" project configuration via 'projections'
Plug 'tpope/vim-projectionist'

" automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'tpope/vim-sleuth'

" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" pairs of handy bracket mappings; e.g. [<Space> and ]<Space> add newlines before and after the cursor line
Plug 'tpope/vim-unimpaired'

" Vim sugar for the UNIX shell commands that need it the most; e.g. :Find, :Wall
Plug 'tpope/vim-eunuch'

" Make Vim persist editing state without fuss
Plug 'kopischke/vim-stay'

" Make Vim handle line and column numbers in file names with a minimum of fuss
Plug 'kopischke/vim-fetch'

" The ultimate undo history visualizer for VIM
Plug 'mbbill/undotree'

" Speed up Vim by updating folds only when called-for.
Plug 'Konfekt/FastFold'

" Sane buffer/window deletion.
Plug 'mhinz/vim-sayonara'

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" All the world's indeed a stage and we are merely players
Plug 'junegunn/limelight.vim'

" interact with tmux
Plug 'benmills/vimux'

" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" Wrapper of some vim/neovim's :terminal functions
Plug 'kassio/neoterm'

" Tame the quickfix window
Plug 'romainl/vim-qf'

" A very simple plugin that makes hlsearch more useful.
Plug 'romainl/vim-cool'
" }

" Git -- Tools for using git and github {
" Awesome git wrapper
Plug 'tpope/vim-fugitive'

" Show git diff via Vim sign column.
Plug 'airblade/vim-gitgutter'

" Github extension for fugitive
Plug 'tpope/vim-rhubarb'
" }

" Autocomplete / Snippets {
" Fast, Extensible, Async Completion Framework for Neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-clang' " C/C++
Plug 'zchee/deoplete-go' " Golang
Plug 'sebastianmarkow/deoplete-rust' " Rust
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " Javascript
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'

"UltiSnips - The ultimate snippet solution for Vim
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }

" Linting / Formatting {
" Asynchronous Lint Engine
Plug 'w0rp/ale'

" Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'Chiel92/vim-autoformat'
" }

" Navigation -- Fuzzy find, searching, etc {
let g:fzf_command_prefix = 'FZF'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Helps you win at grep.
Plug 'mhinz/vim-grepper'

" - for netrw current directory
Plug 'tpope/vim-vinegar'
" }

" Language configuration {
" Testing {
Plug 'janko-m/vim-test'
" }

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

" Clojure {
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
" }

" Go {
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
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
" }

" TypeScript {
Plug 'leafgarland/typescript-vim'
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
" }
" }

" Text objects {
" allows you to configure % to match more than just single characters
Plug 'vim-scripts/matchit.zip'

" Create your own text objects
Plug 'kana/vim-textobj-user'

" Underscore text-object for Vim
Plug 'lucapette/vim-textobj-underscore'

" custom text object for selecting ruby blocks
Plug 'nelstrom/vim-textobj-rubyblock'

" A convenient text object for last pasted text
Plug 'saaguero/vim-textobj-pastedtext'

"Text objects for functions
Plug 'kana/vim-textobj-function'

" A Vim text object for ERB blocks.
Plug 'whatyouhide/vim-textobj-erb'

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" Text objects for foldings
Plug 'kana/vim-textobj-fold'
" }

" Load user plugins
runtime! user/plug.vim

call plug#end()

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  PlugInstall --sync | q
endif


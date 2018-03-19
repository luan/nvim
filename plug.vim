call plug#begin('~/.local/share/nvim/plugged')

" Color schemes {{{
  Plug 'joshdick/onedark.vim'
" }}}

" UI -- User interface additions {{{
  " Fancy start page with recent files, etc
  Plug 'mhinz/vim-startify'

  " Dim inactive window to make it more ovbious where the focus is
  Plug 'blueyed/vim-diminactive'

  " Show trailing whitespace in red
  Plug 'bronson/vim-trailing-whitespace'

  " Plugin to toggle, display and navigate marks
  Plug 'kshenoy/vim-signature'

  " Lightweight status line
  Plug 'itchyny/lightline.vim'
" }}}

" Editing -- Text manipulation helpers {{{
  " (Un-)comment code
  Plug 'tpope/vim-commentary'

  " Multiple cursors
  Plug 'terryma/vim-multiple-cursors'

  " Visual context when bulk editing buffers
  Plug 'pelodelfuego/vim-swoop'

  " Select regions incrementally
  Plug 'terryma/vim-expand-region'

  " Automatically close pairs such as () or []
  Plug 'jiangmiao/auto-pairs'

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
" }}}

" General -- Helpful generic tools with no dependencies {{{
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
" }}}

" Git -- Tools for using git and github {{{
  " Awesome git wrapper
  Plug 'tpope/vim-fugitive'

  " Show git diff via Vim sign column.
  Plug 'airblade/vim-gitgutter'

  " Github extension for fugitive
  Plug 'tpope/vim-rhubarb'
" }}}

" Autocomplete / Snippets {{{
  " Fast, Extensible, Async Completion Framework for Neovim
  Plug 'roxma/nvim-completion-manager'
  Plug 'roxma/ncm-clang' " C/C++
  Plug 'roxma/nvim-cm-racer' " Rust
  Plug 'roxma/nvim-cm-tern', {'do': 'npm install'} " Javascript
  Plug 'calebeby/ncm-css' " CSS
  Plug 'rhysd/github-complete.vim' "GitHub
  Plug 'Shougo/neco-syntax'
  Plug 'Shougo/neco-vim'
  Plug 'roxma/ncm-rct-complete' " Ruby

  "UltiSnips - The ultimate snippet solution for Vim
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
" }}}

" Linting / Formatting {{{
  " Asynchronous Lint Engine
  Plug 'w0rp/ale'

  " Provide easy code formatting in Vim by integrating existing code formatters.
  Plug 'Chiel92/vim-autoformat'
" }}}

" Navigation -- Fuzzy find, searching, etc {{{
  let g:fzf_command_prefix = 'FZF'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Helps you win at grep.
  Plug 'mhinz/vim-grepper'
" }}}

call plug#end()

augroup config#plug
  autocmd!
  autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | q
        \| endif
augroup END


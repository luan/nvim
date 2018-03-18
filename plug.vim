call plug#begin('~/.local/share/nvim/plugged')

" Color schemes {{{
  Plug 'joshdick/onedark.vim'
" }}}

" UI -- User interface additions {{{
  " Fancy start page with recent files, etc
  Plug 'mhinz/vim-startify'

  " Dim inactive window to make it more ovbious where the focus is
  Plug 'blueyed/vim-diminactive'

  " Show git diff via Vim sign column.
  Plug 'airblade/vim-gitgutter'

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

  " quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens
  Plug 'tpope/vim-surround'

  " enable repeating supported plugin maps with '.'
  Plug 'tpope/vim-repeat'

  " Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.
  Plug 'maxbrunsfeld/vim-emacs-bindings'
" }}}
call plug#end()

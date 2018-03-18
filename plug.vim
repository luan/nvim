call plug#begin('~/.local/share/nvim/plugged')

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

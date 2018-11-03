" The Neovim Config
" Maintainer: Luan Santos <https://github.com/luan>
" Version:    2.0

scriptencoding utf-8

" Setup user preferences
if !isdirectory(expand('<sfile>:h') . '/user')
  silent! execute '!cp -a ' . expand('<sfile>:h') . '/user.defaults ' . expand('<sfile>:h') . '/user'
endif

runtime user/before.vim
runtime update.vim " Auto-update (once every 24 hours)
runtime plug.vim
runtime! include/*.vim
runtime! lang/*.vim
runtime keyboard.vim
runtime user/after.vim
runtime colorscheme.vim

" Allow project specific configuration
set exrc
set secure

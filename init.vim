" The Neovim Config
" Maintainer: Luan Santos <https://github.com/luan>
" Version:    2.0

scriptencoding utf-8

if !isdirectory(expand('<sfile>:h') . '/user')
  silent! execute '!cp -a ' . expand('<sfile>:h') . '/user.defaults ' . expand('<sfile>:h') . '/user'
endif

runtime! user/before.vim
runtime! plug.vim
runtime! include/*.vim
runtime! lang/*.vim
runtime! keyboard.vim
runtime! user/after.vim
runtime! colorscheme.vim

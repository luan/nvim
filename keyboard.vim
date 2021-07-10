" Disable plugin mappings
let g:swoopUseDefaultKeyMap = 0
let g:gitgutter_map_keys = 0
let g:dispatch_no_maps = 1

" Leader mappings {{{
" Leader is <Space>
let g:mapleader=' '
let g:maplocalleader = ','
call which_key#register('<Space>', "g:leader_key_map")

let g:leader_key_map=  {}

let g:leader_key_map[' '] = {
      \ 'name': '+general',
      \ 'f': [':FocusMode',  'Focus-mode: remove gutter info for a cleaner experience'],
      \ 'z': [':Goyo',  'Zen-mode: distraction free editing'],
      \ }

let g:leader_key_map.t = {
      \ 'name': '+testing',
      \ 't': [':TestNearest', 'Run Nearest'],
      \ '.': [':TestLast',    'Run Last'],
      \ 'f': [':TestFile',    'Run File'],
      \ 's': [':TestSuite',   'Run Suite'],
      \ 'g': [':TestVisit',   'Goto last ran test'],
      \ }

nmap <silent> <leader>f- :execute(':FZFFiles ' . expand('%:h'))<CR>
let g:leader_key_map.f['-'] = 'File Browser'

let g:leader_key_map.s = {
      \ 'name': '+search',
      \ 'p': ['<Plug>CtrlSFPrompt', 'Find in directory (ctrlsf)'],
      \ }

let g:leader_key_map.c = {
      \ 'name': '+cscope',
      \ 's': [':cs find s <cword>', 'Cscope Symbol'],
      \ 'g': [':cs find g <cword>', 'Cscope Definition'],
      \ 'c': [':cs find c <cword>', 'Cscope Callers'],
      \ 'd': [':cs find d <cword>', 'Cscope Callees'],
      \ 'a': [':cs find a <cword>', 'Cscope Assignments'],
      \ 'o': [':cs add cscope.out', 'Cscope Open Database'],
      \
      \ 'z': [':!sh -xc ''starscope -e cscope -e ctags''', 'Cscope Build Database'],
      \ }


" g mappings {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)


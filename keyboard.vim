" Full redraw finxing syntax highlight bugs
nnoremap <silent> <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" coc.nvim
imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
inoremap <silent><expr> <M-space> coc#refresh()

" coc.nvim diagnostics
nmap <silent> [v <Plug>(coc-diagnostic-prev)
nmap <silent> ]v <Plug>(coc-diagnostic-next)

" ALE
nmap <silent> <M-p> <Plug>(ale_previous_wrap)
nmap <silent> <M-n> <Plug>(ale_next_wrap)

" Eanble completion with tab/shift-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Extra commentary mappings
xmap <c-_>  <Plug>Commentary
omap <c-_>  <Plug>Commentary
nmap <c-_>  <Plug>CommentaryLine

" Mimic behavior from D, C
nnoremap Y y$

vnoremap > >gv
vnoremap < <gv

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Save with enter
function! keyboard#should_save_on_enter()
  return bufname('%') !=# 'swoopBuf' && empty(&buftype)
endfunction
nnoremap <silent> <expr> <CR> keyboard#should_save_on_enter() ? ':call SaveIfUnsaved()<CR>' : '<CR>'

" Emmet
let g:user_emmet_leader_key='<leader>e'
let g:user_emmet_mode='nv'              " only enable normal and visual mode functions

" Escape to clear search
nnoremap <silent> <esc> :noh<cr>

" Close and delete buffer
nnoremap <silent> <M-q> :Sayonara<cr>

" Copy to system clipboard
vnoremap Y "+y

" Disable search highlight
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>


" Disable plugin mappings
let g:swoopUseDefaultKeyMap = 0
let g:gitgutter_map_keys = 0
let g:dispatch_no_maps = 1

nnoremap <silent> <c-p> :Clap files<CR>

" Leader mappings {{{
" Leader is <Space>
let g:mapleader=' '
let g:maplocalleader = ','

nnoremap <silent><nowait> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent><nowait> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent><nowait> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent><nowait> <localleader> :<c-u>WhichKeyVisual ','<CR>

call which_key#register('<Space>', "g:leader_key_map")

let g:leader_key_map=  {}

let g:leader_key_map[' '] = {
      \ 'name': '+general',
      \ 'c': [':Clap command', 'Search commands'],
      \ 'a': [':Clap colors', 'Search colorshcemes'],
      \ }

let g:leader_key_map.t = {
      \ 'name': '+testing',
      \ 't': [':TestNearest', 'Run Nearest'],
      \ '.': [':TestLast',    'Run Last'],
      \ 'f': [':TestFile',    'Run File'],
      \ 's': [':TestSuite',   'Run Suite'],
      \ 'g': [':TestVisit',   'Goto last ran test'],
      \ }

let g:leader_key_map.f = {
      \ 'name': '+files',
      \ 'f': [':Clap files',          'File Search'],
      \ 'h': [':Clap files --hidden', 'File Search (hidden)'],
      \ 'o': [':Clap buffers',        'Open Buffer Search'],
      \ 'm': [':Clap history',        'Recent Files Search'],
      \ '-': [':Clap filer',          'File Browser'],
      \ '.': ['<c-^>',                'Goto Last Buffer'],
      \ }

let g:leader_key_map.h = {
      \ 'name': '+hunks',
      \ 't': [':GitGutterToggle',             'Toggle Git Gutter'],
      \ 'p': ['<Plug>(GitGutterPreviewHunk)', 'Preview Hunk'],
      \ 's': ['<Plug>(GitGutterStageHunk)',   'Stage Hunk'],
      \ 'u': ['<Plug>(GitGutterUndoHunk)',    'Undo Hunk'],
      \ }

let g:leader_key_map.g = { 'name': '+git' }
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Clap commits<CR>
nnoremap <silent> <leader>gk :Clap bcommits<CR>
nnoremap <silent> <leader>gb :Gblame<CR>

let g:leader_key_map.s = { 'name': '+search' }
nnoremap <silent> <leader>sg :Grepper<CR>
nnoremap <silent> <leader>sf :Clap grep <CR>
nnoremap <silent> <leader>st :Clap tags<CR>
nnoremap <silent> <leader>sl :Clap lines<CR>
nnoremap <silent> <leader>sb :Clap blines<CR>

let g:leader_key_map.c = {
      \ 'name': '+cscope',
      \ 's': ['cs find s <cword>', 'Cscope Symbol'],
      \ 'g': ['cs find g <cword>', 'Cscope Definition'],
      \ 'c': ['cs find c <cword>', 'Cscope Callers'],
      \ 'd': ['cs find d <cword>', 'Cscope Callees'],
      \ 'a': ['cs find a <cword>', 'Cscope Assignments'],
      \ 'o': ['cs add cscope.out', 'Cscope Open Database'],
      \
      \ 'z': ['!sh -xc ''starscope -e cscope -e ctags -x "*.go" -x "*.js"''', 'Cscope Build Database'],
      \ }


let g:leader_key_map.e = { 'name': '+emmet' }

let g:leader_key_map.l = {
      \ 'name': '+language-server',
      \ 'k': [':call CocAction("doHover")',    'Hover'],
      \ 's': [':Clap tags',                    'Symbols'],
      \ 't': [':Vista!!',                      'Tag Bar'],
      \ }

nmap <silent> <leader>la <Plug>(coc-codeaction)
vmap <silent> <leader>la <Plug>(coc-codeaction-selected)
let g:leader_key_map.l.a = 'Code Action'

nmap <silent> <leader>l= <Plug>(coc-format)
vmap <silent> <leader>l= <Plug>(coc-format-selected)
let g:leader_key_map.l['='] = 'Code Format'

nmap <silent> <leader>lr <Plug>(coc-rename)
let g:leader_key_map.l.r = 'Rename'

nmap <silent> <leader>lf <Plug>(coc-fix-current)
let g:leader_key_map.l.f = 'Autofix Current'

let g:leader_key_map.b = {
      \ 'name' : '+buffer' ,
      \ 'd' : ['bd',            'Delete Buffer'],
      \ 'h' : ['Startify',      'Home Buffer'],
      \ 'l' : ['b#',            'Last Buffer'],
      \ 'n' : ['bnext',         'Next Buffer'],
      \ 'p' : ['bprevious',     'Previous Buffer'],
      \ 's' : [':Clap buffers', 'Search Buffer'],
      \ }

" }}}

" g mappings {{{

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" These unfortunately would make it so defaults don't work, so we can't yet
" have a menu for non leader mappings.

" nnoremap <silent> g :<c-u>WhichKey 'g'<CR>
" vnoremap <silent> g :<c-u>WhichKeyVisual 'g'<CR>

" call which_key#register('g', "g:g_key_map")

" let g:g_key_map=  {}

" let g:g_key_map.d = 'Go to definition'
" let g:g_key_map.y = 'Go to type'
" let g:g_key_map.i = 'Go to implementation'
" let g:g_key_map.r = 'Find references'

" let g:g_key_map['#'] = 'which_key_ignore'
" let g:g_key_map['*'] = 'which_key_ignore'
" let g:g_key_map['F'] = 'which_key_ignore'
" let g:g_key_map['/'] = 'which_key_ignore'
" let g:g_key_map['b'] = 'which_key_ignore'
" let g:g_key_map['%'] = 'which_key_ignore'
" let g:g_key_map['x'] = 'which_key_ignore'

" " from plugins

" " splitjoin
" let g:g_key_map.J = 'Smart join lines'
" let g:g_key_map.S = 'Smart split lines'

" " swap
" let g:g_key_map['<'] = 'Swap left'
" let g:g_key_map['>'] = 'Swap right'
" let g:g_key_map.s = 'Swap Mode'

" " commentary
" let g:g_key_map.c = 'Comment (<control-/>)'
" let g:g_key_map.cc = 'which_key_ignore'

" }}}

" [] mappings {{{

" hunk jumping (changes)
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" }}}


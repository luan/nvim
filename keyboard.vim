if executable('yarn')
  " coc.nvim
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  vmap <C-j> <Plug>(coc-snippets-select)
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'
  inoremap <silent><expr> <M-space> coc#refresh()

  " coc.nvim diagnostics
  nmap <silent> [v <Plug>(coc-diagnostic-prev)
  nmap <silent> ]v <Plug>(coc-diagnostic-next)
else
  " UltiSnips
  let g:UltiSnipsExpandTrigger = '<c-j>'
  let g:UltiSnipsJumpForwardTrigger = '<c-f>'
  let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
  let g:UltiSnipsRemoveSelectModeMappings = 0
endif

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
nnoremap <expr> <CR> keyboard#should_save_on_enter() ? ':w<CR>' : '<CR>'

" Emmet
let g:user_emmet_leader_key='<leader>e'
let g:user_emmet_mode='nv'              " only enable normal and visual mode functions

" Escape to clear search
nnoremap <silent> <esc> :noh<cr>

" Close and delete buffer
nnoremap <silent> <M-q> :Sayonara<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

" Leader is <Space>
let g:mapleader=' '
let g:maplocalleader = ','

" Copy to system clipboard
vnoremap Y "+y

" Disable search highlight
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

let g:lmap =  {}

" Disable plugin mappings
let g:swoopUseDefaultKeyMap = 0
let g:gitgutter_map_keys = 1

function! s:leaderGuideDisplay()
  let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
  let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
  let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '^:', '', '')
endfunction
let g:leaderGuide_displayfunc = [function('s:leaderGuideDisplay')]

call leaderGuide#register_prefix_descriptions('<Space>', 'g:lmap')
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

let g:lmap[' '] = { 'name': 'General' }
nnoremap <leader><leader>c :FZFCommands<CR>

let g:lmap.t = { 'name': 'Testing' }
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>t. :TestLast<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tg :TestVisit<CR>

let g:lmap.f = { 'name': 'Files' }
nnoremap <silent> <leader>ff :FZFFiles<CR>
nnoremap <silent> <leader>fo :FZFBuffers<CR>
nnoremap <silent> <leader>fm :FZFHistory<CR>
nnoremap <silent> <Plug>(open-alternate) <c-^>
nmap     <silent> <leader>f. <Plug>(open-alternate)

let g:lmap.h = { 'name': 'Hunks' }
let g:lmap.g = { 'name': 'Git' }
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :FZFCommits<CR>
nnoremap <silent> <leader>gk :FZFBCommits<CR>
nnoremap <silent> <leader>gb :Gblame<CR>

let g:lmap.s = { 'name': 'Search' }
nnoremap <silent> <leader>sg :Grepper<CR>
let g:lmap.s.f = [':FZFRg ', 'FZFRg']
nnoremap <silent> <leader>st :FZFTags<CR>
nnoremap <silent> <leader>sl :FZFLines<CR>

let g:lmap.c = { 'name': 'Cscope' }
let g:lmap.c.s = ['cs find s <cword>',                                            'Cscope Symbol']
let g:lmap.c.g = ['cs find g <cword>',                                            'Cscope Definition']
let g:lmap.c.c = ['cs find c <cword>',                                            'Cscope Callers']
let g:lmap.c.d = ['cs find d <cword>',                                            'Cscope Callees']
let g:lmap.c.a = ['cs find a <cword>',                                            'Cscope Assignments']
let g:lmap.c.z = ['!sh -xc ''starscope -e cscope -e ctags -x "*.go" -x "*.js"''', 'Cscope Build Database']
let g:lmap.c.o = ['cs add cscope.out',                                            'Cscope Open Database']

let g:lmap.e = { 'name': 'Emmet (HTML toolkit)' }

let g:lmap.l = { 'name': 'Language Server' }

let g:lmap.l.k =  [':call CocAction("doHover")',        'Hover']

let g:lmap.l.s =  [':Vista finder coc',                 'Symbols']
let g:lmap.l.t =  [':Vista coc',                        'Tag Bar']
let g:lmap.l.ct = [':Vista!',                           'Close Tag Bar']

nmap <silent> <leader>la <Plug>(coc-codeaction)
vmap <silent> <leader>la <Plug>(coc-codeaction-selected)

nmap <silent> <leader>l= <Plug>(coc-format)
vmap <silent> <leader>l= <Plug>(coc-format-selected)

nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lf <Plug>(coc-fix-current)

nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>ly <Plug>(coc-type-definition)

nnoremap <silent> <c-p> :FZFFiles<CR>


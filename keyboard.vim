" UltiSnips
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-f>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'

" AutoPairs
inoremap <silent> <expr> <M-p> AutoPairsToggle()
inoremap <silent> <M-n> <ESC>:call AutoPairsJump()<CR>a

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

" Save with enter
function! keyboard#should_save_on_enter()
	return bufname('%') !=# 'swoopBuf' && empty(&buftype)
endfunction
nnoremap <expr> <CR> keyboard#should_save_on_enter() ? ':w<CR>' : '<CR>'

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
nnoremap <leader>sf :FZFRg 
nnoremap <silent> <leader>st :FZFTags<CR>
nnoremap <silent> <leader>sl :FZFLines<CR>

nnoremap <silent> <c-p> :FZFFiles<CR>


" UltiSnips
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-f>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'

" ALE
nmap <silent> <M-n> <Plug>(ale_previous_wrap)
nmap <silent> <M-p> <Plug>(ale_next_wrap)

" Eanble completion with tab/shift-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Extra commentary mappings
xmap <c-_>  <Plug>Commentary
omap <c-_>  <Plug>Commentary
nmap <c-_>  <Plug>CommentaryLine

" Save with enter
nnoremap <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'

" Escape to clear search
nnoremap <silent> <esc> :noh<cr>

" Close and delete buffer
nnoremap <silent> <M-q> :Sayonara<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

" Terminal
tnoremap <Esc> <C-\><C-n>

" Leader is <Space>
let g:mapleader=' '
let g:maplocalleader = ','

let g:lmap =  {}

" Disable plugin mappings
let g:swoopUseDefaultKeyMap = 0
let g:gitgutter_map_keys = 0

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

let g:lmap.t = { 'name': 'Testing' }
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>t. :TestLast<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tg :TestVisit<CR>


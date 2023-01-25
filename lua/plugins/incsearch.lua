vim.g['incsearch#auto_nohlsearch'] = 0

vim.keymap.set('', '/', '<Plug>(incsearch-forward)')
vim.keymap.set('', '?', '<Plug>(incsearch-backward)')
vim.keymap.set('', 'g/', '<Plug>(incsearch-stay)')
vim.keymap.set('', 'n', '<Plug>(incsearch-nohl-n)')
vim.keymap.set('', 'N', '<Plug>(incsearch-nohl-N)')
vim.keymap.set('', '*', '<Plug>(incsearch-nohl-*)')
vim.keymap.set('', '#', '<Plug>(incsearch-nohl-#)')
vim.keymap.set('', 'g*', '<Plug>(incsearch-nohl-g*)')
vim.keymap.set('', 'g#', '<Plug>(incsearch-nohl-g#)')

return {
	'haya14busa/incsearch.vim',
}

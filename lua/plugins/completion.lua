_G.completionCR = function()
	if vim.fn.pumvisible() == 1 and vim.fn.complete_info()['selected'] ~= -1 then
		return vim.api.nvim_replace_termcodes("<Plug>(completion_confirm_completion)", true, true, true)
	else
		return vim.api.nvim_replace_termcodes("<CR><Plug>DiscretionaryEnd<Plug>CloserClose", true, true, true)
	end
end

vim.g.closer_no_mappings = 1
vim.g.endwise_no_mappings = 1
vim.g.completion_enable_snippet = 'vim-vsnip'
vim.g.completion_confirm_key = ''
vim.g.completion_enable_auto_paren = 1
vim.g.completion_menu_length = 40
vim.g.completion_popup_border = 'shadow'

local map = require('utils').map
map('si', "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], {expr = true})
map('si', "<S-Tab>", [[pumvisible() ? "<C-p>" : "<S-Tab>"]], {expr = true})
map('i', '<c-y>', [[<Plug>(completion_trigger)]], {silent = true})
map('i', '<tab>',   '<Plug>(completion_smart_tab)')
map('i', '<s-tab>', '<Plug>(completion_smart_s_tab)')
map('i', '<CR>', [[v:lua.completionCR()]], {silent = true, expr = true})
map('i', '<c-y>', [[v:lua.completionCR()]], {silent = true, expr = true})

map('si', '<C-j>',   [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)'         : '<C-j>']], {expr = true})
map('i', '<C-k>',   [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'         : '<Esc>lDa']], {expr = true})
map('s', '<C-k>',   [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'         : '<C-k>']], {expr = true})

vim.cmd [[
augroup config#completion
  autocmd!
  autocmd BufEnter * lua require('completion').on_attach()
augroup END
]]

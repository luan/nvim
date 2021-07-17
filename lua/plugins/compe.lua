require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        buffer = {kind = "﬘", true},
        vsnip = {kind = "﬌", true},
        calc = true,
        path = true,
        nvim_lsp = true,
        nvim_lua = true,
    }
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn['vsnip#available'](1) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end
_G.compeCR = function()
	if vim.fn.pumvisible() == 1 and vim.fn.complete_info()['selected'] ~= -1 then
		vim.fn['compe#confirm']('<CR>')
	else
		return vim.api.nvim_replace_termcodes("<CR><Plug>DiscretionaryEnd<Plug>CloserClose", true, true, true)
	end
end

vim.g.closer_no_mappings = 1
vim.g.endwise_no_mappings = 1

local map = require('utils').map
map('si', "<Tab>", "v:lua.tab_complete()", {expr = true})
map('si', "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

map('i', '<C-x><C-x>', [[compe#complete()]], {silent = true, expr = true})
map('i', '<CR>', [[v:lua.compeCR()]], {silent = true, expr = true})
map('i', '<c-y>', [[v:lua.compeCR()]], {silent = true, expr = true})

map('si', '<C-j>',   [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)'         : '<C-j>']], {expr = true})
map('si', '<C-k>',   [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'         : '<C-j>']], {expr = true})

local map = vim.api.nvim_set_keymap
local wk = require("which-key")

-- emacs bindings
map('i', '<C-b>', '<Left>', {})
map('i', '<C-f>', '<Right>', {})
map('i', '<C-a>', '<Home>', {})
map('i', '<C-e>', '<End>', {})
map('i', '<C-d>', '<Del>', {})
map('i', '<C-h>', '<BS>', {})
map('i', '<C-k>', '<Esc>lDa', {noremap = true})
map('c', '<C-p>', '<Up>', {})
map('c', '<C-n>', '<Down>', {})
map('c', '<C-b>', '<Left>', {})
map('c', '<C-f>', '<Right>', {})
map('c', '<C-a>', '<Home>', {})
map('c', '<C-e>', '<End>', {noremap = true})
map('c', '<C-d>', '<Del>', {noremap = true})
map('c', '<C-h>', '<BS>', {noremap = true})
map('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', {noremap = true})

-- Diagnostics
map('n', '<M-p>', [[:Lspsaga diagnostic_jump_prev<cr>]], {silent = true})
map('n', '<M-n>', [[:Lspsaga diagnostic_jump_next<cr>]], {silent = true})

-- Full redraw finxing syntax highlight bugs
map('n', '<c-l>', [[:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>]], {noremap = true, silent = true})


-- Mimic behavior from D, C
map('n', 'Y', 'y$', {noremap = true})

-- Indent/un-indent
map('v', '>', '>gv', {noremap = true})
map('v', '<', '<gv', {noremap = true})

map('v', '<Tab>', '>gv', {noremap = true})
map('v', '<S-Tab>', '<gv', {noremap = true})

-- Save on enter
map('n', '<CR>', [[(bufname('%') !=# 'swoopBuf' && empty(&buftype)) ? ':w<CR>' : '<CR>']], {noremap = true, silent = true, expr = true})

-- Copy to system clipboard
map('n', 'Y', '"+y', {noremap = true})

-- Escape to clear search
map('n', '<esc>', ':noh<cr>', {noremap = true, silent = true})

-- Fuzzy finding
map('n', '<C-p>', [[<cmd>FZFFiles<cr>]], {noremap = true})

-- Current file's path in command mode
map('c', '%%', [[expand('%:h').'/']], {noremap = true, expr = true})

-- lspsaga scrolling
-- scroll down hover doc or scroll in definition preview
map('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], {noremap = true, silent = true})
-- scroll up hover doc
map('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], {noremap = true, silent = true})

-- LSP remaps
wk.register({
    g = {
        D = {function() vim.lsp.buf.declaration() end, 'Go to declaration'},
        d = {function() vim.lsp.buf.definition() end, 'Go to definition'},
        y = {function() vim.lsp.buf.type_definition() end, 'Go to type'},
        i = {function() vim.lsp.buf.implementation() end, 'Find implementation'},
        h = {[[<cmd>Lspsaga lsp_finder<cr>]], 'Smart find refereces/implementation'},
        r = {function() vim.lsp.buf.references() end, 'Find refereces'},
        K = {[[<cmd>Lspsaga signature_help<cr>]], 'Show signature'},
    },
}, {silent = true})

map('n', 'K', [[<cmd>Lspsaga hover_doc<cr>]], {silent = true})

wk.register({
    name = "+general",
    s = {':Dashboard<cr>', 'Home Buffer'},
    c = {':Telescope commands<cr>', 'Search commands'},
    a = {':Telescope colorshceme<cr>', 'Search colorschemes'},
}, {prefix = '<leader> '})

wk.register({
    name = "+files",
    f = {':Telescope fd<cr>', 'File Search'},
    o = {':Telescope buffers<cr>', 'Buffer Search'},
    m = {':Telescope oldfiles<cr>', 'Recent Files'},
    ['.'] = {'<c-^>', 'Go to last buffer'},
}, {prefix = '<leader>f'})

local gitsigns = require('gitsigns')
wk.register({
    name = "+hunks",
    t = {function() gitsigns.toggle_signs() end, 'Toggle Sign colum'},
    s = {function() gitsigns.stage_hunk() end, 'Stage Hunk'},
    S = {function() gitsigns.undo_stage_hunk() end, 'Unstage Hunk'},
    p = {function() gitsigns.preview_hunk() end, 'Preview Hunk'},
    u = {function() gitsigns.reset_hunk() end, 'Undo Hunk'},
    R = {function() gitsigns.reset_buffer() end, 'Reset Buffer'},
    b = {function() gitsigns.blame_line() end, 'Blame Line'},
    n = {function() gitsigns.toggle_numhl() end, 'Toggle line-num diff'},
    l = {function() gitsigns.toggle_linehl() end, 'Toggle line diff'},
    w = {function() gitsigns.toggle_word_diff() end, 'Toggle word diff'},
}, {prefix = '<leader>h'})

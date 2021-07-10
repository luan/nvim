local map = vim.api.nvim_set_keymap
local wk = require("which-key")
local gitsigns = require('gitsigns')
local telescope = require('telescope.builtin')

-- close buffer
map('n', '<M-q>', [[:lua require('bufdelete').bufdelete(0, true) <cr>]], {noremap = true, silent = true})

-- comments
map('n', '<C-_>', '<Plug>kommentary_line_default', {})
map('v', '<C-_>', '<Plug>kommentary_visual_default', {})

-- emacs bindings
map('i', '<C-b>', '<Left>', {})
map('i', '<M-b>', '<C-Left>', {})

map('i', '<C-f>', '<Right>', {})
map('i', '<M-f>', '<C-Right>', {})

map('i', '<C-d>', '<Del>', {})
map('i', '<M-d>', '<C-Right><C-w>', {})
map('i', '<C-h>', '<BS>', {})

map('i', '<C-a>', '<Home>', {})
map('i', '<C-e>', '<End>', {})
map('i', '<C-k>', '<Esc>lDa', {noremap = true})

map('c', '<C-p>', '<Up>', {})
map('c', '<C-n>', '<Down>', {})

map('c', '<C-b>', '<Left>', {})
map('c', '<M-b>', '<C-Left>', {})

map('c', '<C-f>', '<Right>', {})
map('c', '<M-f>', '<C-Right>', {})

map('c', '<C-d>', '<Del>', {})
map('c', '<M-d>', '<C-Right><C-w>', {noremap = true})
map('c', '<C-h>', '<BS>', {noremap = true})

map('c', '<C-a>', '<Home>', {})
map('c', '<C-e>', '<End>', {noremap = true})
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
        D = {vim.lsp.buf.declaration, 'Go to declaration'},
        d = {telescope.lsp_definitions, 'Go to definition'},
        y = {vim.lsp.buf.type_definition, 'Go to type'},
        i = {telescope.lsp_implementations, 'Find implementation'},
        h = {[[<cmd>Lspsaga lsp_finder<cr>]], 'Smart find refereces/implementation'},
        r = {telescope.lsp_references, 'Find refereces'},
        K = {[[<cmd>Lspsaga signature_help<cr>]], 'Show signature'},
    },
}, {silent = true})

map('n', 'K', [[<cmd>Lspsaga hover_doc<cr>]], {silent = true})

wk.register({
    name = "+general",
    s = {':Dashboard<cr>', 'Home Buffer'},
    c = {telescope.commands, 'Search commands'},
    a = {telescope.colorscheme, 'Search colorschemes'},
    h = {telescope.help_tags, 'Help'},
}, {prefix = '<leader> '})

wk.register({
    name = "+files",
    f = {telescope.find_files, 'File Search'},
    o = {telescope.buffers, 'Buffer Search'},
    m = {telescope.oldfiles, 'Recent Files'},
    ['.'] = {'<c-^>', 'Go to last buffer'},
}, {prefix = '<leader>f'})

wk.register({
    name = "+hunks",
    t = {gitsigns.toggle_signs, 'Toggle Sign colum'},
    s = {gitsigns.stage_hunk, 'Stage Hunk'},
    S = {gitsigns.undo_stage_hunk, 'Unstage Hunk'},
    p = {gitsigns.preview_hunk, 'Preview Hunk'},
    u = {gitsigns.reset_hunk, 'Undo Hunk'},
    R = {gitsigns.reset_buffer, 'Reset Buffer'},
    b = {gitsigns.blame_line, 'Blame Line'},
    n = {gitsigns.toggle_numhl, 'Toggle line-num diff'},
    l = {gitsigns.toggle_linehl, 'Toggle line diff'},
    w = {gitsigns.toggle_word_diff, 'Toggle word diff'},
}, {prefix = '<leader>h'})

wk.register({
    name = "+language-server",
    a = {':Lspsaga code_action<cr>', 'Code Action'},
    ['='] = {vim.lsp.buf.formatting_sync, 'Code Action'},
    r = {':Lspsaga rename<cr>', 'Rename'},
    k = {':Lspsaga hover_doc<cr>', 'Doc'},
    s = {telescope.lsp_dynamic_workspace_symbols, 'Search Symbols'},
    d = {"<cmd>Trouble lsp_document_diagnostics<cr>", 'Diagnostics'},
    D = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", 'Workspace Diagnostics'},
}, {prefix = '<leader>l'})

wk.register({
    name = "+buffer",
    d = {function() require('bufdelete').bufdelete(0, true) end, 'Delete Buffer'},
    l = {':b#<cr>', 'Last buffer'},
    n = {':bnext<cr>', 'Next buffer'},
    p = {':bprevious<cr>', 'Previous buffer'},
    s = {telescope.buffers, 'Search buffers'},
}, {prefix = '<leader>b'})

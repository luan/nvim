local map = require('utils').map
local wk = require('which-key')
local gitsigns = require('gitsigns')
local telescope = require('telescope.builtin')

map('n', '-', [[:lua require('lir.float').init()<cr>]], {noremap = true, silent = true})

-- close buffer
map('n', '<M-q>', [[:Bdelete<cr>]], {noremap = true, silent = true})

-- comments
map('n', '<C-_>', '<Plug>kommentary_line_default')
map('v', '<C-_>', '<Plug>kommentary_visual_default')

-- emacs bindings
map('ic', '<C-b>', '<Left>')
map('ic', '<M-b>', '<C-Left>')

map('ic', '<C-f>', '<Right>')
map('ic', '<M-f>', '<C-Right>')

map('ic', '<C-d>', '<Del>')
map('ic', '<M-d>', '<C-Right><C-w>', {noremap = true})
map('ic', '<C-h>', '<BS>', {noremap = true})

map('ic', '<C-a>', '<Home>', {noremap = true})
map('ic', '<C-e>', '<End>', {noremap = true})

map('c', '<C-p>', '<Up>')
map('c', '<C-n>', '<Down>')

map('i', '<C-k>', '<Esc>lDa', {noremap = true})
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

map('v', '<Tab>',   '>gv', {noremap = true})
map('v', '<S-Tab>', '<gv', {noremap = true})

-- Save on enter
map('n', '<CR>', [[(bufname('%') !=# 'swoopBuf' && empty(&buftype)) ? ':w<CR>' : '<CR>']], {noremap = true, silent = true, expr = true})

-- Copy to system clipboard
map('v', 'Y', '"+y', {noremap = true})

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

map('n', 'K', [[<cmd>Lspsaga hover_doc<cr>]], {silent = true})

wk.register({
    D = {vim.lsp.buf.declaration,             'Go to declaration'},
    d = {telescope.lsp_definitions,           'Go to definition'},
    y = {vim.lsp.buf.type_definition,         'Go to type'},
    m = {telescope.lsp_implementations,       'Find implementation'},
    h = {[[<cmd>Lspsaga lsp_finder<cr>]],     'Smart find references/implementation'},
    r = {telescope.lsp_references,            'Find references'},
    K = {[[<cmd>Lspsaga signature_help<cr>]], 'Show signature'},
    a = {'<Plug>(LiveEasyAlign)',             'EasyAlign', mode = 'x'},
}, {prefix = 'g', silent = true})


wk.register({
    name = "+general",
    s    = {':Alpha<cr>',          'Home Buffer'},
    c    = {telescope.commands,    'Search commands'},
    a    = {telescope.colorscheme, 'Search colorschemes'},
    h    = {telescope.help_tags,   'Help'},
}, {prefix = '<leader> '})

wk.register({
    name = "+files",
    f = {telescope.find_files,                                     'File Search'},
    o = {telescope.buffers,                                        'Buffer Search'},
    m = {telescope.oldfiles,                                       'Recent Files'},
    ['-'] = {function() telescope.file_browser({cwd = '%:h'}) end, 'File Browser'},
    ['.'] = {'<c-^>',                                              'Go to last buffer'},
}, {prefix = '<leader>f'})

wk.register({
    name = "+git",
    s = {':Git<cr>',         'git status'},
    b = {':Git blame<cr>',       'git blame'},
    c = {telescope.git_commits,  'git commits'},
    k = {telescope.git_bcommits, 'git commits (buffer)'},
}, {prefix = '<leader>g'})

wk.register({
    name = "+hunks",
    t    = {gitsigns.toggle_signs,     'Toggle Sign colum'},
    s    = {gitsigns.stage_hunk,       'Stage Hunk'},
    S    = {gitsigns.undo_stage_hunk,  'Unstage Hunk'},
    p    = {gitsigns.preview_hunk,     'Preview Hunk'},
    u    = {gitsigns.reset_hunk,       'Undo Hunk'},
    R    = {gitsigns.reset_buffer,     'Reset Buffer'},
    b    = {gitsigns.blame_line,       'Blame Line'},
    n    = {gitsigns.toggle_numhl,     'Toggle line-num diff'},
    l    = {gitsigns.toggle_linehl,    'Toggle line diff'},
    w    = {gitsigns.toggle_word_diff, 'Toggle word diff'},
}, {prefix = '<leader>h'})

wk.register({
    name  = "+language-server",
    a     = {':Lspsaga code_action<cr>',                   'Code Action'},
    ['='] = {vim.lsp.buf.formatting_sync,              'Format'},
    r     = {':Lspsaga rename<cr>',                        'Rename'},
    k     = {':Lspsaga hover_doc<cr>',                     'Doc'},
    s     = {telescope.lsp_dynamic_workspace_symbols,      'Search Symbols'},
    d     = {"<cmd>Trouble document_diagnostics<cr>",  'Diagnostics'},
    D     = {"<cmd>Trouble workspace_diagnostics<cr>", 'Workspace Diagnostics'},
    t     = {"<cmd>Vista!!<cr>",                           'Symbol tree'},
}, {prefix = '<leader>l'})

wk.register({
    name = "+buffer",
    d    = {function() require('bufdelete').bufdelete(0, true) end, 'Delete Buffer'},
    l    = {':b#<cr>',         'Last buffer'},
    n    = {':bnext<cr>',      'Next buffer'},
    p    = {':bprevious<cr>',  'Previous buffer'},
    s    = {telescope.buffers, 'Search buffers'},
}, {prefix = '<leader>b'})

wk.register({
    name = "+search",
    g    = {'<cmd>Grepper<cr>',                  'Find in directory (quickfix)'},
    f    = {telescope.live_grep,                 'Find in directory (live)'},
    l    = {':FZFLines<cr>',                     'Find in open files'},
    b    = {telescope.current_buffer_fuzzy_find, 'Find in buffer'},
    p    = {require('spectre').open,             'Search & Replace'},
}, {prefix = '<leader>s'})


wk.register({
    name  = "+testing",
    t     = {':TestNearest<cr>', 'Run Nearest'},
    f     = {':TestFile<cr>',    'Run File'},
    s     = {':TestSuite<cr>',   'Run Suite'},
    g     = {':TestVisit<cr>',   'Goto last ran test'},
    ['.'] = {':TestLast<cr>',    'Run Last'},
}, {prefix = '<leader>t'})

map('n', ']t', '<Plug>(ultest-next-fail)')
map('n', '[t', '<Plug>(ultest-prev-fail)')

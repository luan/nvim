local wk = require('which-key')
local gitsigns = require('gitsigns')
local telescope = require('telescope.builtin')
-- local map = vim.keymap.set
local api = vim.api

vim.g.VM_leader = { default = '<space>v', visual = '<space>v', buffer = 'z' }

vim.keymap.set('n', '-', [[:lua require('lir.float').init()<cr>]], { silent = true })

-- close buffer
vim.keymap.set('n', '<M-q>', [[:Bdelete<cr>]], { silent = true })

-- comments
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_current_linewise)')
vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')

-- emacs bindings
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')
vim.keymap.set({ 'i', 'c' }, '<M-b>', '<C-Left>')

vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<M-f>', '<C-Right>')

vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')
vim.keymap.set({ 'i', 'c' }, '<M-d>', '<C-Right><C-w>')
vim.keymap.set({ 'i', 'c' }, '<C-h>', '<BS>')

vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>')

vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')

vim.keymap.set('i', '<C-k>', '<Esc>lDa')
vim.keymap.set('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>')

-- Diagnostics
vim.keymap.set('n', '<M-p>', [[:Lspsaga diagnostic_jump_prev<cr>]], { silent = true })
vim.keymap.set('n', '<M-n>', [[:Lspsaga diagnostic_jump_next<cr>]], { silent = true })

-- Full redraw finxing syntax highlight bugs
vim.keymap.set('n', '<c-l>', [[:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>]], { silent = true })


-- Mimic behavior from D, C
vim.keymap.set('n', 'Y', 'y$')

-- Indent/un-indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Save on enter
vim.keymap.set('n', '<CR>', function()
    if api.nvim_eval([[&modified]]) ~= 1 or api.nvim_eval([[&buftype]]) ~= '' then
        return nil
    end
    vim.schedule(function() vim.cmd("write") end)
end, { expr = true })

-- Copy to system clipboard
vim.keymap.set('v', 'Y', '"+y')

-- Escape to clear search
vim.keymap.set('n', '<esc>', ':noh<cr>', { silent = true })

-- Fuzzy finding
vim.keymap.set('n', '<C-p>', [[<cmd>FZFFiles<cr>]])

-- Current file's path in command mode
vim.keymap.set('c', '%%', [[expand('%:h').'/']], { expr = true })

-- lspsaga scrolling
-- scroll down hover doc or scroll in definition preview
vim.keymap.set('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], { silent = true, })
-- scroll up hover doc
vim.keymap.set('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], { silent = true })

vim.keymap.set('n', 'K', [[<cmd>Lspsaga hover_doc<cr>]], { silent = true })

wk.register({
    D = { vim.lsp.buf.declaration, 'Go to declaration' },
    d = { telescope.lsp_definitions, 'Go to definition' },
    y = { vim.lsp.buf.type_definition, 'Go to type' },
    m = { telescope.lsp_implementations, 'Find implementation' },
    h = { [[<cmd>Lspsaga lsp_finder<cr>]], 'Smart find references/implementation' },
    r = { telescope.lsp_references, 'Find references' },
    K = { [[<cmd>Lspsaga signature_help<cr>]], 'Show signature' },
    a = { '<Plug>(LiveEasyAlign)', 'EasyAlign', mode = 'x' },
}, { prefix = 'g', silent = true })


wk.register({
    name = "+general",
    s    = { ':Alpha<cr>', 'Home Buffer' },
    c    = { telescope.commands, 'Search commands' },
    a    = { telescope.colorscheme, 'Search colorschemes' },
    h    = { telescope.help_tags, 'Help' },
}, { prefix = '<leader> ' })

wk.register({
    name = "+files",
    f = { telescope.find_files, 'File Search' },
    o = { telescope.buffers, 'Buffer Search' },
    m = { telescope.oldfiles, 'Recent Files' },
    ['-'] = { function() telescope.file_browser({ cwd = '%:h' }) end, 'File Browser' },
    ['.'] = { '<c-^>', 'Go to last buffer' },
}, { prefix = '<leader>f' })

wk.register({
    name = "+git",
    s = { ':Git<cr>', 'git status' },
    b = { ':Git blame<cr>', 'git blame' },
    c = { telescope.git_commits, 'git commits' },
    k = { telescope.git_bcommits, 'git commits (buffer)' },
}, { prefix = '<leader>g' })

wk.register({
    name = "+hunks",
    t    = { gitsigns.toggle_signs, 'Toggle Sign colum' },
    s    = { gitsigns.stage_hunk, 'Stage Hunk' },
    S    = { gitsigns.undo_stage_hunk, 'Unstage Hunk' },
    p    = { gitsigns.preview_hunk, 'Preview Hunk' },
    u    = { gitsigns.reset_hunk, 'Undo Hunk' },
    R    = { gitsigns.reset_buffer, 'Reset Buffer' },
    b    = { gitsigns.blame_line, 'Blame Line' },
    n    = { gitsigns.toggle_numhl, 'Toggle line-num diff' },
    l    = { gitsigns.toggle_linehl, 'Toggle line diff' },
    w    = { gitsigns.toggle_word_diff, 'Toggle word diff' },
}, { prefix = '<leader>h' })

wk.register({
    name  = "+language-server",
    a     = { ':Lspsaga code_action<cr>', 'Code Action' },
    ['='] = { vim.lsp.buf.formatting_sync, 'Format' },
    r     = { ':Lspsaga rename<cr>', 'Rename' },
    k     = { ':Lspsaga hover_doc<cr>', 'Doc' },
    s     = { telescope.lsp_dynamic_workspace_symbols, 'Search Symbols' },
    d     = { "<cmd>Trouble document_diagnostics<cr>", 'Diagnostics' },
    D     = { "<cmd>Trouble workspace_diagnostics<cr>", 'Workspace Diagnostics' },
    t     = { "<cmd>Vista!!<cr>", 'Symbol tree' },
}, { prefix = '<leader>l' })

wk.register({
    name = "+buffer",
    d    = { function() require('bufdelete').bufdelete(0, true) end, 'Delete Buffer' },
    l    = { ':b#<cr>', 'Last buffer' },
    n    = { ':bnext<cr>', 'Next buffer' },
    p    = { ':bprevious<cr>', 'Previous buffer' },
    s    = { telescope.buffers, 'Search buffers' },
}, { prefix = '<leader>b' })

wk.register({
    name = "+search",
    g    = { '<cmd>Grepper<cr>', 'Find in directory (quickfix)' },
    f    = { telescope.live_grep, 'Find in directory (live)' },
    l    = { ':FZFLines<cr>', 'Find in open files' },
    b    = { telescope.current_buffer_fuzzy_find, 'Find in buffer' },
    p    = { require('spectre').open, 'Search & Replace' },
}, { prefix = '<leader>s' })


wk.register({
    name  = "+testing",
    t     = { ':TestNearest<cr>', 'Run Nearest' },
    f     = { ':TestFile<cr>', 'Run File' },
    s     = { ':TestSuite<cr>', 'Run Suite' },
    g     = { ':TestVisit<cr>', 'Goto last ran test' },
    ['.'] = { ':TestLast<cr>', 'Run Last' },
}, { prefix = '<leader>t' })

vim.keymap.set('n', ']t', '<Plug>(ultest-next-fail)')
vim.keymap.set('n', '[t', '<Plug>(ultest-prev-fail)')

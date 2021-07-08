local map = vim.api.nvim_set_keymap

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

-- fuzzy finding
map('n', '<C-p>', [[<cmd>FZFFiles<cr>]], {noremap = true})
map('n', '<leader>ff', [[<cmd>FZFFiles<cr>]], {noremap = true})

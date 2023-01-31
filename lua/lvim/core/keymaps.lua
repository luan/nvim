local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
----  Better window navigation
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)

---- Navigate buffers
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
keymap("n", "<A-S-h>", ":BufferMovePrevious<CR>", opts)
keymap("n", "<A-S-l>", ":BufferMoveNext<CR>", opts)

---- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

---- Resize windows
keymap("n", "<A-S-C-j>", ":resize +1<CR>", opts)
keymap("n", "<A-S-C-k>", ":resize -1<CR>", opts)
keymap("n", "<A-S-C-h>", ":vertical resize +1<CR>", opts)
keymap("n", "<A-S-C-l>", ":vertical resize -1<CR>", opts)

---- Move text up/down
-- Visual --
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Block --
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)

---- No highlight
keymap("n", "<Esc>", ":noh<CR>", opts)

---- Go to buffer quickly
keymap("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
keymap("n", "<leader>0", "<Cmd>BufferGoto 10<CR>", opts)

---- Switch two windows
keymap("n", "<A-o>", "<C-w>r", opts)

---- Fuzzy Search
vim.keymap.set("n", "<C-f>", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require "telescope.themes")
end, { desc = "[/] Fuzzily search in current buffer]" })
vim.keymap.set("n", "<A-S-f>", "<cmd>Spectre<cr>", { desc = "Search in project" })
vim.keymap.set("n", "<A-f>", "<cmd>lua require('spectre').open_file_search()<cr>", { desc = "Search in file" })
vim.keymap.set({ "n", "x" }, "<A-S-s>", function()
  require("ssr").open()
end, { desc = "Structured search & replace" })

---- Emacs bindings
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>")
vim.keymap.set({ "i", "c" }, "<M-b>", "<C-Left>")

vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>")
vim.keymap.set({ "i", "c" }, "<M-f>", "<C-Right>")

vim.keymap.set({ "i", "c" }, "<C-d>", "<Del>")
vim.keymap.set({ "i", "c" }, "<M-d>", "<C-Right><C-w>")
vim.keymap.set({ "i", "c" }, "<C-h>", "<BS>")

vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>")
vim.keymap.set({ "i", "c" }, "<C-e>", "<End>")

vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

vim.keymap.set("i", "<C-k>", "<Esc>lDa")
vim.keymap.set("c", "<C-k>", "<C-f>D<C-c><C-c>:<Up>")

---- Save on enter
vim.keymap.set("n", "<CR>", function()
  reload("lvim.utils").save { skip_unmodified = true, format = true }
end, { expr = true })

---- Copy to system clipboard
vim.keymap.set("v", "Y", '"+y')

---- Current file's path in command mode
vim.keymap.set("c", "%%", [[expand('%:h').'/']], { expr = true })

---- Find Files
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<M-p>", "<cmd>Telescope find_files<cr>")

-- vim.keymap.set("n", "<C-p>", function()
--   require("fzf-lua").files()
-- end, { desc = "Find Files" })
-- vim.keymap.set("n", "<M-p>", function()
--   require("fzf-lua").files()
-- end, { desc = "Find Files" })

-- bad habits

vim.keymap.set("n", "<M-e>", "<cmd>NvimTreeFocus<cr>")
vim.keymap.set("n", "<M-b>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<M-\\>", "<cmd>NvimTreeFindFile<cr>")
vim.keymap.set("n", "<M-w>", "<cmd>BufferClose<cr>")
vim.keymap.set("n", "<M-s>", function()
  reload("lvim.utils").save { format = true }
end)

vim.keymap.set("n", "<M-d>", "<Plug>(VM-Find-Under)")
vim.keymap.set("x", "<M-d>", "<Plug>(VM-Find-Subword-Under)")
vim.keymap.set("n", "<M-down>", "<Plug>(VM-Add-Cursor-Down)")
vim.keymap.set("n", "<M-up>", "<Plug>(VM-Add-Cursor-Up)")

vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)")
vim.keymap.set("n", "<M-/>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<M-/>", "<Plug>(comment_toggle_linewise_visual)")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--- oil not vinegar
vim.keymap.set("n", "-", function()
  vim.cmd.edit { args = { vim.fn.expand "%:p:h" } }
end, { silent = true })

-- vim.keymap.set("n", "-", "<cmd>Neotree float toggle reveal_force_cwd<cr>", { desc = "Show floating file browser" })

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
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<A-S-l>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<A-S-h>", ":BufferLineMovePrev<CR>", opts)

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
keymap("v", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-S-k>", ":m .-2<CR>==", opts)
-- Block --
keymap("x", "<A-S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-S-k>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-S-k>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-S-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-S-k>", "<ESC>:m .-2<CR>==gi", opts)

---- No highlight
keymap("n", "<Esc>", ":noh<CR>", opts)

---- Go to buffer quickly
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<leader>0", "<Cmd>BufferLineGoToBuffer 10<CR>", opts)

---- split window
keymap("n", "<leader>\\", ":vsplit<CR>", opts)
keymap("n", "<leader>/", ":split<CR>", opts)

---- Switch two windows
keymap("n", "<A-o>", "<C-w>r", opts)

---- Fuzzy Search
vim.keymap.set("n", "<C-f>", function()
   -- You can pass additional configuration to telescope to change theme, layout, etc.
   require("telescope.builtin").current_buffer_fuzzy_find(require "telescope.themes")
end, { desc = "[/] Fuzzily search in current buffer]" })

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
   if vim.api.nvim_eval [[&modified]] ~= 1 or vim.api.nvim_eval [[&buftype]] ~= "" then
      return nil
   end
   vim.schedule(function()
      vim.lsp.buf.format()
      vim.cmd "silent! write"
   end)
end, { expr = true })

---- Save without formatting
vim.keymap.set("n", "<M-CR>", function()
   if vim.api.nvim_eval [[&modified]] ~= 1 or vim.api.nvim_eval [[&buftype]] ~= "" then
      return nil
   end
   vim.schedule(function()
      vim.cmd "noautocmd write"
   end)
end, { expr = true })

---- Copy to system clipboard
vim.keymap.set("v", "Y", '"+y')

---- Current file's path in command mode
vim.keymap.set("c", "%%", [[expand('%:h').'/']], { expr = true })

---- Find Files
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")

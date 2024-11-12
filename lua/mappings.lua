require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<c-p>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "x", "V")
map("v", "x", "j")
map("n", "<cr>", "<cmd> w <cr>")
map("n", "<C-c>", "gcc", { desc = "toggle comment", remap = true })
map("x", "<C-c>", "gc", { desc = "toggle comment", remap = true })


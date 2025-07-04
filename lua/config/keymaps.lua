-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<CR>", function()
  if vim.bo.buftype == "" then
    vim.cmd("w")
  else
    local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end
end, { desc = "Save file (regular buffers only)" })
map({ "n", "v" }, "<C-c>", "gcc", { desc = "Toggle comment", remap = true })

-- readline
local readline = require("readline")
vim.keymap.set("!", "<C-k>", readline.kill_line)
vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
vim.keymap.set("!", "<M-d>", readline.kill_word)
vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
vim.keymap.set("!", "<C-w>", readline.unix_word_rubout)
vim.keymap.set("!", "<C-d>", "<Delete>") -- delete-char
vim.keymap.set("!", "<C-h>", "<BS>") -- backward-delete-char
vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
vim.keymap.set("!", "<C-e>", readline.end_of_line)
vim.keymap.set("!", "<M-f>", readline.forward_word)
vim.keymap.set("!", "<M-b>", readline.backward_word)
vim.keymap.set("!", "<C-f>", "<Right>") -- forward-char
vim.keymap.set("!", "<C-b>", "<Left>") -- backward-char
vim.keymap.set("!", "<C-n>", "<Down>") -- next-line
vim.keymap.set("!", "<C-p>", "<Up>") -- previous-line

-- map alt + ; to c-y to confirm completions
vim.keymap.set("i", "<M-;>", "<C-y>", { desc = "Confirm completion", remap = true })

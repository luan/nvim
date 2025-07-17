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
map("!", "<C-k>", readline.kill_line)
map("!", "<C-u>", readline.backward_kill_line)
map("!", "<M-d>", readline.kill_word)
map("!", "<M-BS>", readline.backward_kill_word)
map("!", "<C-w>", readline.unix_word_rubout)
map("!", "<C-d>", "<Delete>") -- delete-char
map("!", "<C-h>", "<BS>") -- backward-delete-char
map("!", "<C-a>", readline.beginning_of_line)
map("!", "<C-e>", readline.end_of_line)
map("!", "<M-f>", readline.forward_word)
map("!", "<M-b>", readline.backward_word)
map("!", "<C-f>", "<Right>") -- forward-char
map("!", "<C-b>", "<Left>") -- backward-char
map("!", "<C-n>", "<Down>") -- next-line
map("!", "<C-p>", "<Up>") -- previous-line

-- map alt + ; to c-y to confirm completions
vim.keymap.set("i", "<M-;>", "<C-y>", { desc = "Confirm completion", remap = true })

-- Buffer navigation
map("n", "<M-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
map("n", "<M-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
map("n", "<M-q>", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
map("n", "<M-w>", "<cmd>bd<cr>", { desc = "Pick buffer to go to" })

-- Snacks Explorer
map("n", "<M-b>", function()
  Snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

map("n", "<M-e>", function()
  local existing = Snacks.picker.get({ source = "explorer" })[1]

  if existing and not existing.closed then
    existing:focus()
  else
    Snacks.explorer()
  end
end, { desc = "Open/Focus Snacks Explorer" })

-- Open current file in Xcode at current line and column
map("n", "<M-x>", function()
  local file_path = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")

  if file_path ~= "" then
    vim.fn.system({ "xed", "-l", tostring(line), tostring(col), file_path })
  else
    vim.notify("No file to open", vim.log.levels.WARN)
  end
end, { desc = "Open current file in Xcode" })

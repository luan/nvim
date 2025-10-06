local map = vim.keymap.set

local readline = require("readline")

local insert_undo_stack = {}
local function save_insert_state()
  if vim.fn.mode() == "i" then
    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    table.insert(insert_undo_stack, { line = line, pos = pos })
    if #insert_undo_stack > 10 then
      table.remove(insert_undo_stack, 1)
    end
  end
end

local function simple_undo()
  local mode = vim.fn.mode()
  if mode == "i" and #insert_undo_stack > 0 then
    local last_state = table.remove(insert_undo_stack)
    vim.api.nvim_set_current_line(last_state.line)
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], last_state.pos })
  elseif mode == "c" then
    return "<C-u>"
  end
end

local function wrap_with_undo(func)
  return function()
    save_insert_state()
    return func()
  end
end

-- Readline mappings with undo support
local readline_mappings = {
  { "<C-k>", wrap_with_undo(readline.kill_line) },
  { "<C-u>", wrap_with_undo(readline.backward_kill_line) },
  { "<M-d>", wrap_with_undo(readline.kill_word) },
  { "<M-BS>", wrap_with_undo(readline.backward_kill_word) },
  { "<C-w>", wrap_with_undo(readline.backward_kill_word) },
  { "<C-d>", "<Delete>" },
  { "<C-h>", "<BS>" },
  { "<C-a>", readline.beginning_of_line },
  { "<C-e>", readline.end_of_line },
  { "<M-f>", readline.forward_word },
  { "<M-b>", readline.backward_word },
  { "<C-f>", "<Right>" },
  { "<C-b>", "<Left>" },
  { "<C-n>", "<Down>" },
  { "<C-p>", "<Up>" },
}

for _, mapping in ipairs(readline_mappings) do
  map("!", mapping[1], mapping[2])
end

-- Undo keymaps
local undo_keys = { "<C-/>", "<C-_>" }
for _, key in ipairs(undo_keys) do
  map("i", key, simple_undo, { desc = "Simple undo (insert mode)" })
  map("c", key, "<C-u>", { desc = "Clear command line" })
end

-- Disable LazyVim terminal toggles
for _, key in ipairs(undo_keys) do
  map("n", key, "<nop>", { desc = "Disabled" })
  map("t", key, key, { desc = "Pass to shell for undo" })
end

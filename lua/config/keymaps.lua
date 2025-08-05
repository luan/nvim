-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Helper functions to reduce duplication
local function toggle_with_restore(toggle_fn, _)
  return function()
    local current_win = vim.api.nvim_get_current_win()
    local current_mode = vim.fn.mode()
    local in_insert = current_mode == "i"

    toggle_fn()

    vim.schedule(function()
      if vim.api.nvim_win_is_valid(current_win) then
        vim.api.nvim_set_current_win(current_win)
        if in_insert then
          vim.cmd("startinsert")
        else
          vim.cmd("stopinsert")
        end
      end
    end)
  end
end

local function focus_or_open(check_fn, open_fn, _)
  return function()
    local existing = check_fn()
    if existing then
      vim.api.nvim_set_current_win(existing)
      if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert")
      end
    else
      open_fn()
    end
  end
end

-- File operations
map("n", "<CR>", function()
  if vim.bo.buftype == "" then
    vim.cmd("w")
  else
    local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end
end, { desc = "Save file (regular buffers only)" })

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Comments
local comment_keys = { "<C-c>", "<D-/>" }
for _, key in ipairs(comment_keys) do
  map({ "n", "v" }, key, "gcc", { desc = "Toggle comment", remap = true })
end

-- Readline setup
local readline = require("readline")

-- Simple undo for insert mode
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
  { "<C-w>", wrap_with_undo(readline.unix_word_rubout) },
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

-- Buffer navigation
local buffer_mappings = {
  { "<M-h>", "<cmd>BufferLineMovePrev<cr>", "Move buffer left" },
  { "<M-l>", "<cmd>BufferLineMoveNext<cr>", "Move buffer right" },
  { "<M-q>", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
  { "<M-w>", "<cmd>bd<cr>", "Close buffer" },
}

for _, mapping in ipairs(buffer_mappings) do
  map("n", mapping[1], mapping[2], { desc = mapping[3] })
end

-- Window cycling
map("n", "<D-o>", "<C-w><C-w>", { desc = "Cycle windows" })
map("t", "<D-o>", "<C-\\><C-n><C-w><C-w>", { desc = "Cycle windows from terminal" })

-- LSP
map("n", "<D-.>", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Disable LazyVim terminal toggles
for _, key in ipairs(undo_keys) do
  map("n", key, "<nop>", { desc = "Disabled" })
  map("t", key, key, { desc = "Pass to shell for undo" })
end

-- Claude Code integration
local function find_claude_window()
  return vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.api.nvim_buf_get_name(buf):match("claude%-code")
  end, vim.api.nvim_list_wins())[1]
end

map(
  { "n", "i" },
  "<D-i>",
  focus_or_open(find_claude_window, function()
    require("claude-code").toggle()
  end, "Focus Claude Code (open if not exists)")
)

-- Claude Code toggle without focus
map(
  "n",
  "<D-l>",
  toggle_with_restore(function()
    require("claude-code").toggle()
  end, "Toggle Claude Code (no focus)")
)

map(
  "i",
  "<D-l>",
  toggle_with_restore(function()
    require("claude-code").toggle()
  end, "Toggle Claude Code (no focus)")
)

map("t", "<D-l>", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local current_win = vim.api.nvim_get_current_win()
  require("claude-code").toggle()

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      if bufname:match("claude%-code") then
        vim.cmd("stopinsert")
      else
        vim.cmd("startinsert")
      end
    end
  end)
end, { desc = "Toggle Claude Code (no focus)" })

-- Terminal integration
local function find_terminal_window()
  local wins = vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.bo[buf].buftype == "terminal" and not vim.api.nvim_buf_get_name(buf):match("claude%-code")
  end, vim.api.nvim_list_wins())
  return wins[1]
end

-- Terminal toggle without focus
map(
  "n",
  "<D-j>",
  toggle_with_restore(function()
    Snacks.terminal.toggle()
  end, "Toggle Terminal")
)

map(
  "i",
  "<D-j>",
  toggle_with_restore(function()
    Snacks.terminal.toggle()
  end, "Toggle Terminal")
)

map("t", "<D-j>", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local current_win = vim.api.nvim_get_current_win()

  if bufname:match("claude%-code") then
    Snacks.terminal()
  else
    Snacks.terminal.toggle()
  end

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      vim.cmd("startinsert")
    end
  end)
end, { desc = "Toggle Terminal / Open regular terminal from Claude Code" })

-- Terminal focus
map(
  "n",
  "<C-`>",
  focus_or_open(find_terminal_window, function()
    Snacks.terminal()
    vim.cmd("startinsert")
  end, "Focus Terminal")
)

-- Snacks Explorer
map(
  "n",
  "<D-b>",
  toggle_with_restore(function()
    Snacks.explorer()
  end, "Toggle Snacks Explorer")
)

map("t", "<D-b>", function()
  local current_win = vim.api.nvim_get_current_win()
  Snacks.explorer()
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      vim.cmd("startinsert")
    end
  end, 10)
end, { desc = "Toggle Snacks Explorer" })

map("n", "<D-e>", function()
  local existing = Snacks.picker.get({ source = "explorer" })[1]
  if existing and not existing.closed then
    existing:focus()
  else
    Snacks.explorer()
  end
end, { desc = "Open/Focus Snacks Explorer" })

-- External tools integration
map("n", "<M-x>", function()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    vim.fn.system({ "xed", "-l", tostring(line), tostring(col), file_path })
  else
    vim.notify("No file to open", vim.log.levels.WARN)
  end
end, { desc = "Open current file in Xcode" })

-- LSP
map("n", "<S-r>", function()
  local inc_rename = require("inc_rename")
  return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename (inc-rename.nvim)" })

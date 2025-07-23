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
map({ "n", "v" }, "<D-/>", "gcc", { desc = "Toggle comment", remap = true })

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- readline
local readline = require("readline")

-- Simple undo for insert mode only (command line undo is complex)
local insert_undo_stack = {}
local function save_insert_state()
  local mode = vim.fn.mode()
  if mode == "i" then
    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    table.insert(insert_undo_stack, { line = line, pos = pos })
    -- Keep only last 10 states
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
    -- For command line, just use built-in undo if available
    return "<C-u>"
  end
end

-- Wrap some functions to save state
local function wrap_with_undo(func)
  return function()
    save_insert_state()
    return func()
  end
end

map("!", "<C-k>", wrap_with_undo(readline.kill_line))
map("!", "<C-u>", wrap_with_undo(readline.backward_kill_line))
map("!", "<M-d>", wrap_with_undo(readline.kill_word))
map("!", "<M-BS>", wrap_with_undo(readline.backward_kill_word))
map("!", "<C-w>", wrap_with_undo(readline.unix_word_rubout))
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

-- Simple undo keymaps (terminal uses shell's own undo)
map("i", "<C-/>", simple_undo, { desc = "Simple undo (insert mode)" })
map("i", "<C-_>", simple_undo, { desc = "Simple undo (insert mode)" })
map("c", "<C-/>", "<C-u>", { desc = "Clear command line" })
map("c", "<C-_>", "<C-u>", { desc = "Clear command line" })

-- Buffer navigation
map("n", "<M-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
map("n", "<M-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
map("n", "<M-q>", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
map("n", "<M-w>", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Window cycling - alternative to <C-h> for Claude Code
map("n", "<D-o>", "<C-w><C-w>", { desc = "Cycle windows" })
map("t", "<D-o>", "<C-\\><C-n><C-w><C-w>", { desc = "Cycle windows from terminal" })

-- Terminal
map("n", "<D-.>", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Note: readline.undo doesn't exist in the plugin

-- Override LazyVim's default terminal toggle keymaps
map("n", "<C-/>", "<nop>", { desc = "Disabled" })
map("n", "<C-_>", "<nop>", { desc = "Disabled" })
-- Let terminal pass <C-/> and <C-_> to shell for native undo
map("t", "<C-/>", "<C-/>", { desc = "Pass to shell for undo" })
map("t", "<C-_>", "<C-_>", { desc = "Pass to shell for undo" })

-- Add Claude Code focus keymap
map("n", "<D-i>", function()
  local claude_wins = vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    return bufname:match("claude%-code")
  end, vim.api.nvim_list_wins())

  if #claude_wins > 0 then
    vim.api.nvim_set_current_win(claude_wins[1])
  else
    require("claude-code").toggle()
  end
end, { desc = "Focus Claude Code (open if not exists)" })

-- Override Claude Code toggle to not focus and ensure it starts
map("n", "<D-l>", function()
  local current_win = vim.api.nvim_get_current_win()

  -- Check if Claude Code is already running
  local claude_wins = vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    return bufname:match("claude%-code")
  end, vim.api.nvim_list_wins())

  if #claude_wins > 0 then
    -- Close existing Claude Code
    require("claude-code").toggle()
  else
    -- Open Claude Code
    require("claude-code").toggle()
  end

  -- Use vim.schedule to ensure we run after the plugin
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      -- Force normal mode
      vim.cmd("stopinsert")
    end
  end)
end, { desc = "Toggle Claude Code (no focus)" })

map("t", "<D-l>", function()
  local current_win = vim.api.nvim_get_current_win()
  require("claude-code").toggle()
  if vim.api.nvim_win_is_valid(current_win) then
    vim.api.nvim_set_current_win(current_win)
    vim.cmd("startinsert") -- Always restore insert in terminal mode
  end
end, { desc = "Toggle Claude Code (no focus)" })

-- Terminal toggle and focus keymaps - toggle without focus
map("n", "<D-j>", function()
  local current_win = vim.api.nvim_get_current_win()

  Snacks.terminal.toggle()

  -- Use vim.schedule to ensure we run after the terminal plugin
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      -- Force normal mode
      vim.cmd("stopinsert")
    end
  end)
end, { desc = "Toggle Terminal" })

map("t", "<D-j>", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local current_win = vim.api.nvim_get_current_win()
  if bufname:match("claude%-code") then
    -- In Claude Code terminal, open a regular terminal
    Snacks.terminal()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      vim.cmd("startinsert") -- Always restore insert in terminal mode
    end
  else
    -- In regular terminal, toggle it
    Snacks.terminal.toggle()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      vim.cmd("startinsert") -- Always restore insert in terminal mode
    end
  end
end, { desc = "Toggle Terminal / Open regular terminal from Claude Code" })

-- Terminal focus keymap - open and focus existing or create new
map("n", "<C-`>", function()
  -- Check if terminal already exists
  local term_wins = vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.bo[buf].buftype == "terminal" and not vim.api.nvim_buf_get_name(buf):match("claude%-code")
  end, vim.api.nvim_list_wins())

  if #term_wins > 0 then
    -- Focus existing terminal
    vim.api.nvim_set_current_win(term_wins[1])
    vim.cmd("startinsert")
  else
    -- Open new terminal and focus
    Snacks.terminal()
    vim.cmd("startinsert")
  end
end, { desc = "Focus Terminal" })

-- Snacks Explorer - toggle without focus
map("n", "<D-b>", function()
  local current_win = vim.api.nvim_get_current_win()

  Snacks.explorer()

  -- Use vim.schedule to ensure we run after the plugin
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
      -- Force normal mode
      vim.cmd("stopinsert")
    end
  end)
end, { desc = "Toggle Snacks Explorer" })

map("t", "<D-b>", function()
  local current_win = vim.api.nvim_get_current_win()

  Snacks.explorer()
  vim.defer_fn(function()
    vim.api.nvim_set_current_win(current_win)
    vim.cmd("startinsert") -- Always restore insert in terminal mode
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

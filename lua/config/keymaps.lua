-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- File operations
map("n", "<CR>", function()
  if vim.bo.buftype == "" then
    vim.cmd("w")
  else
    local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end
end, { desc = "Save file (regular buffers only)" })

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>noau w<cr><esc>", { desc = "Save File (without formatting)" })

-- Copy filepath with line number (relative)
map("n", "<D-S-c>", function()
  local filepath = vim.fn.expand("%:.")
  local line = vim.fn.line(".")
  local text = filepath .. ":" .. line
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end, { desc = "Copy filepath with line number" })

-- Copy filepath with line number (absolute)
map("n", "<D-M-S-c>", function()
  local filepath = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local text = filepath .. ":" .. line
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end, { desc = "Copy absolute filepath with line number" })

-- Comments
local comment_keys = { "<C-c>", "<D-/>" }
for _, key in ipairs(comment_keys) do
  map({ "n" }, key, "gcc", { desc = "Toggle comment", remap = true })
  map({ "v" }, key, "gc", { desc = "Toggle comment", remap = true })
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

-- Buffer navigation
local buffer_mappings = {
  { "<M-h>", "<cmd>BufferLineMovePrev<cr>", "Move buffer left" },
  { "<M-l>", "<cmd>BufferLineMoveNext<cr>", "Move buffer right" },
  { "<M-q>", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
  {
    "<M-w>",
    function()
      Snacks.bufdelete()
    end,
    "Close buffer",
  },
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

-- Terminal integration
local function find_terminal_window()
  local wins = vim.tbl_filter(function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.bo[buf].buftype == "terminal"
      and not (vim.api.nvim_buf_get_name(buf):match("claude") or vim.api.nvim_buf_get_name(buf):match("opencode"))
  end, vim.api.nvim_list_wins())
  return wins[1]
end

-- Terminal mode escape to normal mode
map("t", "<C-]>", "<C-\\><C-n>", { desc = "Exit terminal mode to normal mode" })

-- Terminal toggle with focus
map({ "n", "i" }, "<D-j>", function()
  local term_win = find_terminal_window()
  if term_win then
    if vim.api.nvim_get_current_win() == term_win then
      -- If we're in the terminal, toggle it closed
      Snacks.terminal.toggle()
    else
      -- If terminal exists but we're not in it, focus it
      vim.api.nvim_set_current_win(term_win)
      vim.cmd("startinsert")
    end
  else
    -- No terminal exists, open and focus
    Snacks.terminal()
    vim.cmd("startinsert")
  end
end, { desc = "Toggle/Focus Terminal" })

map("t", "<D-j>", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match("claude%-code") or bufname:match("opencode") then
    -- From Claude Code terminal, open regular terminal
    Snacks.terminal()
    vim.cmd("startinsert")
  else
    -- From regular terminal, toggle it closed
    Snacks.terminal.toggle()
  end
end, { desc = "Toggle Terminal / Open regular terminal from Claude Code" })

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

-- Xcode workspace
map("n", "<D-x>", function()
  local cwd = vim.fn.getcwd()
  local workspaces = {}

  -- Find all .xcworkspace directories
  for _, item in ipairs(vim.fn.readdir(cwd)) do
    local path = cwd .. "/" .. item
    if vim.fn.isdirectory(path) == 1 and item:match("%.xcworkspace$") then
      table.insert(workspaces, path)
    end
  end

  if #workspaces == 0 then
    vim.notify("No .xcworkspace directories found in current directory", vim.log.levels.WARN)
    return
  elseif #workspaces == 1 then
    vim.fn.system({ "open", workspaces[1] })
    vim.notify("Opened " .. vim.fn.fnamemodify(workspaces[1], ":t"))
  else
    local items = {}
    for i, workspace in ipairs(workspaces) do
      table.insert(items, {
        idx = i,
        text = vim.fn.fnamemodify(workspace, ":t"),
        path = workspace,
      })
    end

    Snacks.picker({
      title = "Select Xcode Workspace",
      layout = {
        preview = false,
        width = 0.4,
        height = 0.3,
      },
      items = items,
      format = function(item, _)
        return {
          { item.text, "String" },
        }
      end,
      confirm = function(picker, item)
        picker:close()
        vim.fn.system({ "open", item.path })
        vim.notify("Opened " .. item.text)
      end,
    })
  end
end, { desc = "Open Xcode workspace" })

-- LSP
map("n", "<S-r>", function()
  local inc_rename = require("inc_rename")
  return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename (inc-rename.nvim)" })

if vim.fn.executable("lazygit") == 1 then
  map("n", "<C-g>", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>GG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
end

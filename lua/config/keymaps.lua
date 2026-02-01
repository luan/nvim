-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

require("config.xcode")
require("config.readline")

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

map({ "i", "x", "n", "s" }, "<M-[>90;2", "<cmd>noau w<cr><esc>", { desc = "Save File (without formatting)" })

-- Copy filepath (normal) or filepath with line range (visual)
map("n", "<M-[>90;3", function()
  local filepath = vim.fn.expand("%:.")
  vim.fn.setreg("+", filepath)
  vim.notify("Copied: " .. filepath)
end, { desc = "Copy filepath" })

map("v", "<M-[>90;3", function()
  local filepath = vim.fn.expand("%:.")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local text
  if start_line == end_line then
    text = filepath .. ":" .. start_line
  else
    text = filepath .. ":" .. start_line .. "-" .. end_line
  end
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end, { desc = "Copy filepath with line range" })

-- Copy absolute filepath (normal) or with line range (visual)
map("n", "<M-[>90;4", function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.setreg("+", filepath)
  vim.notify("Copied: " .. filepath)
end, { desc = "Copy absolute filepath" })

map("v", "<M-[>90;4", function()
  local filepath = vim.fn.expand("%:p")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local text
  if start_line == end_line then
    text = filepath .. ":" .. start_line
  else
    text = filepath .. ":" .. start_line .. "-" .. end_line
  end
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end, { desc = "Copy absolute filepath with line range" })

-- Comments
local comment_keys = { "<C-c>", "<M-/>" }
for _, key in ipairs(comment_keys) do
  map({ "n" }, key, "gcc", { desc = "Toggle comment", remap = true })
  map({ "v" }, key, "gc", { desc = "Toggle comment", remap = true })
end

map("n", "<M-S-q>", "<cmd>qall<cr>", { desc = "Quit all" })

-- Buffer navigation
local buffer_mappings = {
  { "<M-h>", "<cmd>BufferLineMovePrev<cr>", "Move buffer left" },
  { "<M-l>", "<cmd>BufferLineMoveNext<cr>", "Move buffer right" },
  { "<M-q>", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
  { "<M-S-w>", "<cmd>BufferLineCloseOthers<cr>", "Close all other buffers" },
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
map("n", "<M-[>90;5", "<C-w><C-w>", { desc = "Cycle windows" })
map("t", "<M-[>90;5", "<C-\\><C-n><C-w><C-w>", { desc = "Cycle windows from terminal" })

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
map({ "n", "i" }, "<M-[>90;1", function()
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

map("t", "<M-[>90;1", function()
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

map("n", "<M-[>90;6", vim.lsp.buf.code_action, { desc = "Code Action" })

map("n", "<S-r>", function()
  local inc_rename = require("inc_rename")
  return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename (inc-rename.nvim)" })

if vim.fn.executable("lazygit") == 1 then
  map("n", "<C-g>", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
end

map("n", "<leader>cd", "<cmd>RustLsp openCargo<cr>", { desc = "Open package's Cargo.toml" })
map("n", "<leader>cD", "<cmd>e Cargo.toml<cr>", { desc = "Open workspace's Cargo.toml" })

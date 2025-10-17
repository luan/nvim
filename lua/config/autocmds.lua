-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Simple socket management - start server if not already running
local function ensure_socket()
  if not vim.v.servername or vim.v.servername == "" then
    -- Generate simple socket path
    local socket_path = "/tmp/nvim_" .. vim.fn.getpid()
    vim.fn.serverstart(socket_path)
  end

  -- Store the socket path
  if vim.v.servername and vim.v.servername ~= "" then
    vim.g.nvim_socket_path = vim.v.servername
  end
end

-- Ensure socket on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = ensure_socket,
  desc = "Ensure socket for Claude Code",
})

-- Terminals should not have a title bar (winbar)
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
  pattern = "*",
  callback = function(ev)
    local buf = ev.buf or vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype == "terminal" then
      vim.wo.winbar = ""
      pcall(vim.api.nvim_set_option_value, "winbar", "", { scope = "local", win = vim.api.nvim_get_current_win() })
    end
  end,
  desc = "Clear winbar for terminal windows",
})

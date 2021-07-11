local M = {}

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local map = vim.api.nvim_set_keymap
M.map = function(modes, key, action, opts)
  opts = opts or {}
  modes:gsub(".", function(mode)
    map(mode, key, action, opts)
  end)
end

return M

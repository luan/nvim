local M = {}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.t = t

return M

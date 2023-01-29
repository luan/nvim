local M = {}

function M.merge(...)
  return vim.tbl_deep_extend("force", {}, ...)
end

return M

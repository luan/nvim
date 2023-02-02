local M = {}

---@type boolean
M.is_windows = vim.loop.os_uname().version:match "Windows"

---@type boolean
M.is_mac = vim.loop.os_uname().sysname == "Darwin"

---@type string
M.sep = M.is_windows and "\\" or "/"

---@param filepath string
---@return boolean
M.exists = function(filepath)
  local stat = vim.loop.fs_stat(filepath)
  return stat ~= nil and stat.type ~= nil
end

---@return string
M.join = function(...)
  return table.concat({ ... }, M.sep)
end

M.is_absolute = function(path)
  if M.is_windows then
    return path:lower():match "^%w:"
  else
    return vim.startswith(path, "/")
  end
end

M.abspath = function(path)
  if not M.is_absolute(path) then
    path = vim.fn.fnamemodify(path, ":p")
  end
  return path
end

return M

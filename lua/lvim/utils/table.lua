local M = {}

function M.merge(...)
  return vim.tbl_deep_extend("force", {}, ...)
end

function M.merge_lists(...)
  local result = {}
  local lists = { ... }
  for _, list in ipairs(lists) do
    for _, element in ipairs(list) do
      table.insert(result, element)
    end
  end
  return result
end

return M

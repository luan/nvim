local function distance(a, b)
  local result = 0
  local a_parts = vim.split(a, "/")
  local b_parts = vim.split(b, "/")
  for i = 1, math.min(#a_parts, #b_parts) do
    if a_parts[i] ~= b_parts[i] then
      break
    end
    result = result + 1
  end
  return result
end

return function(a, b, c)
  local a_distance = distance(a, c)
  local b_distance = distance(b, c)
  if a_distance == b_distance then
    return a < b
  end
  return a_distance > b_distance
end

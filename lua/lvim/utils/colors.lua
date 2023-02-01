local M = {}

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  local r, g, b = tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
  return r, g, b
end

function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.brighten(hex, percent)
  local r, g, b = M.hex_to_rgb(hex)
  r = math.min(math.floor(r + (255 - r) * percent), 255)
  g = math.min(math.floor(g + (255 - g) * percent), 255)
  b = math.min(math.floor(b + (255 - b) * percent), 255)
  return M.rgb_to_hex(r, g, b)
end

function M.darken(hex, percent)
  local r, g, b = M.hex_to_rgb(hex)
  r = math.max(math.floor(r * (1 - percent)), 0)
  g = math.max(math.floor(g * (1 - percent)), 0)
  b = math.max(math.floor(b * (1 - percent)), 0)
  return M.rgb_to_hex(r, g, b)
end

function M.get_hl_fg(name)
  local ret = vim.api.nvim_get_hl_by_name(name, true)
  if type(ret.foreground) ~= "number" then
    return nil
  end

  return string.format("#%06x", ret.foreground)
end

function M.get_hl_bg(name)
  local ret = vim.api.nvim_get_hl_by_name(name, true)
  if type(ret.background) ~= "number" then
    return nil
  end

  return string.format("#%06x", ret.background)
end

return M

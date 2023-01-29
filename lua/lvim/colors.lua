local function hex_to_rgb(hex)
  local r, g, b = tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
  return r, g, b
end

local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

local function brighten(hex, percent)
  local r, g, b = hex_to_rgb(hex)
  r = math.min(math.floor(r + (255 - r) * percent), 255)
  g = math.min(math.floor(g + (255 - g) * percent), 255)
  b = math.min(math.floor(b + (255 - b) * percent), 255)
  return rgb_to_hex(r, g, b)
end

local function darken(hex, percent)
  local r, g, b = hex_to_rgb(hex)
  r = math.max(math.floor(r * (1 - percent)), 0)
  g = math.max(math.floor(g * (1 - percent)), 0)
  b = math.max(math.floor(b * (1 - percent)), 0)
  return rgb_to_hex(r, g, b)
end

local function get_hl_fg(name)
  local ret = vim.api.nvim_get_hl_by_name(name, true)
  if type(ret.foreground) ~= "number" then
    return nil
  end

  local hex = string.format("%06x", ret.foreground)
  return brighten(hex, 0.3)
end

local highlights = {
  "@function",
  "@method",
  "@readonly",
  "@local",
  "@modifier",
  "@namespace",
  "@interface",
  "Constant",
  "String",
  "Character",
  "Number",
  "Boolean",
  "Identifier",
  "Float",
  "Comment",
  "Function",
  "Statement",
  "Conditional",
  "Repeat",
  "Label",
  "Operator",
  "Keyword",
  "Exception",
  "PreProc",
  "Include",
  "Define",
  "Macro",
  "PreCondit",
  "Type",
  "StorageClass",
  "Structure",
  "Typedef",
  "Special",
  "SpecialChar",
  "Delimiter",
  "SpecialComment",
}

local color_set = {}

for _, hl in ipairs(highlights) do
  local fg = get_hl_fg(hl)
  if fg ~= nil and not color_set[fg] then
    color_set[fg] = true
  end
end

local colors = {}

for color, _ in pairs(color_set) do
  table.insert(colors, color)
end

return colors

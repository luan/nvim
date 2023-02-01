local color_utils = require "lvim.utils.colors"

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
  local fg = color_utils.get_hl_fg(hl)
  if fg ~= nil then
    fg = color_utils.brighten(fg, 0.3)
    if fg ~= nil and not color_set[fg] then
      color_set[fg] = true
    end
  end
end

local colors = {}

for color, _ in pairs(color_set) do
  table.insert(colors, color)
end

return colors

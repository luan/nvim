local colorscheme_group = vim.api.nvim_create_augroup("colorscheme", { clear = true })
local color_utils = require "lvim.utils.colors"

local function colorscheme_callback()
  local bg = color_utils.get_hl_bg "TelescopeNormal"
  if not bg then
    bg = color_utils.get_hl_bg "StatusLine"
  end

  vim.api.nvim_command("hi NormalFloat guibg=" .. bg)
  vim.api.nvim_command("hi TelescopeNormal guibg=" .. bg)
  vim.api.nvim_command("hi TelescopeBorder guifg=" .. bg)
  vim.api.nvim_command("hi TelescopePromptNormal guibg=" .. bg)
  vim.api.nvim_command("hi FloatBorder guifg=" .. bg)
  vim.api.nvim_command("hi ToggleTermBorder guifg=" .. bg)
  vim.api.nvim_command("hi FzfLuaBorder guifg=" .. bg)
  vim.api.nvim_command "hi link FzfLuaNormal TelescopeNormal"
  vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "?*",
  callback = function()
    vim.schedule(colorscheme_callback)
  end,
  group = colorscheme_group,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "?*",
  callback = function()
    vim.schedule(colorscheme_callback)
  end,
  group = colorscheme_group,
})

vim.cmd.colorscheme { args = { lvim.colorscheme } }

-- Some themes do not trigger the autocmd in time and we lose our precious dotted line
---@diagnostic disable-next-line: param-type-mismatch
vim.defer_fn(colorscheme_callback, 2000)

local colorscheme_group = vim.api.nvim_create_augroup("colorscheme", { clear = true })
local color_utils = require "lvim.utils.colors"

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "?*",
  callback = function()
    vim.schedule(function()
      local bg = color_utils.get_hl_bg "TelescopeNormal"
      vim.api.nvim_command("hi FloatBorder guifg=" .. bg)
      vim.api.nvim_command("hi ToggleTermBorder guifg=" .. bg)
      vim.api.nvim_command("hi TelescopeBorder guifg=" .. bg)
      vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"
    end)
  end,
  group = colorscheme_group,
})

vim.cmd.colorscheme { args = { "tokyonight-night" } }

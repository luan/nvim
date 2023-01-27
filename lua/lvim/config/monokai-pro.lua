local monokai = require "monokai-pro"
monokai.setup {
   transparent_background = true,
   italic_comments = true,
   filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
   inc_search = "underline", -- underline | background
   background_clear = {},
   diagnostic = {
      background = true,
   },
   plugins = {
      bufferline = {
         underline_selected = false,
         underline_visible = false,
      },
      indent_blankline = {
         context_highlight = "pro", -- default | pro
      },
      lualine = {
         float = true,
         colorful = true,
      },
   },
}

local highlight = function(group, value)
   local link = value.link
   if link ~= nil then
      local cmd = "hi! link " .. group .. " " .. link
      vim.api.nvim_command(cmd)
      return
   end
   local generatedHlValue = genHlValue(value)
   vim.api.nvim_set_hl(0, group, generatedHlValue)
end

monokai.load()
vim.api.nvim_command "hi IndentBlanklineContextStart gui=underdotted"

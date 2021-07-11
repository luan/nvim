local map = require('utils').map
local t = require('utils').t

_G.restore_register = function()
    vim.fn.setreg('"', vim.b.restore_register)
    return ''
end

_G.visual_replace = function()
  vim.b.restore_register = vim.fn.getreg('"')
  return t([[p@=v:lua.restore_register()<CR>]])
end

map('v', 'p', "v:lua.visual_replace()", {noremap = true, silent = true, expr = true})

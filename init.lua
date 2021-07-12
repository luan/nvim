require('globals')

local has_module  = require('utils').has_module
local file_exists = require('utils').file_exists
local copy = require('utils').copy

if not(file_exists(CONFIG_PATH .. '/lua/user')) then
    copy(CONFIG_PATH .. '/lua/user.defaults', CONFIG_PATH .. '/lua/user')
end

if has_module('user.before') then
    require('user.before')
end

require('settings')
require('plugins')
require('colorscheme')
require('keyboard')
require('diagnostics')
require('paste')
require('lang')

if has_module('user.after') then
    require('user.after')
end

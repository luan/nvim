require "lvim.globals"
reload "lvim.core.options"
require "lvim.core.lazy"
require("lvim.utils.modules").load_user_config()
require "lvim.core.autocmds"
reload "lvim.core.keymaps"
require "lvim.core.colorscheme"

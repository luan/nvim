_G.reload = require("lvim.utils.modules").reload
_G.require_safe = require("lvim.utils.modules").require_safe
_G.CONFIG_PATH = vim.fn.stdpath "config"
_G.DATA_PATH = vim.fn.stdpath "data"
_G.CACHE_PATH = vim.fn.stdpath "cache"
_G.tbl = reload "lvim.utils.table"
_G.lvim = {
  log = { level = "INFO" },
}

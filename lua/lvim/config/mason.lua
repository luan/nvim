local mason = require_safe "mason"
if not mason then
  return
end

local settings = {
  ui = {
    border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
require("mason-lspconfig").setup {
  automatic_installation = true,
}
require("mason-lspconfig").setup_handlers {
  require("lvim.lsp")._setup_server,
}

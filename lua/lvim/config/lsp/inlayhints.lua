local M = {}

M.on_attach = function(client, buffer)
  require("lsp-inlayhints").on_attach(client, buffer)
end

require("lsp-inlayhints").setup()

return M

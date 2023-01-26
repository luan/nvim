-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  local config = { -- your config
    virtual_text = luanvim.lsp.diagnostics.virtual_text,
    signs = luanvim.lsp.diagnostics.signs,
    underline = luanvim.lsp.diagnostics.underline,
    update_in_insert = luanvim.lsp.diagnostics.update_in_insert,
    severity_sort = luanvim.lsp.diagnostics.severity_sort,
    float = luanvim.lsp.diagnostics.float,
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, luanvim.lsp.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, luanvim.lsp.float)
end

return M

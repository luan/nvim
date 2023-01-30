local M = {}
local logger = require "lvim.core.log"

function M.setup(name, opts)
  logger:debug("adding lsp config for " .. name .. "...")
  if lvim.lsp == nil or lvim.lsp.servers == nil then
    logger:warn("attempted to setup server " .. name .. " while lvim.lsp is nil")
    return
  end

  lvim.lsp.servers = tbl.merge(lvim.lsp.servers, { [name] = opts })
  M._setup_server(name)
end

function M._setup_server(name)
  if lvim.lsp == nil or lvim.lsp.servers == nil then
    logger:warn "attempted to setup servers while lvim.lsp is nil"
    return
  end
  logger:debug("setting up lsp for " .. name .. "...")
  local config = {}
  if lvim.lsp.servers[name] then
    logger:debug("found config for " .. name)
    config = lvim.lsp.servers[name]
  end
  config = tbl.merge(config, {
    capabilities = M._extended_capabilities(),
  })
  require("lspconfig")[name].setup(config)
  local bufnr = vim.api.nvim_get_current_buf()
  require("lspconfig")[name].manager.try_add_wrapper(bufnr)
end

function M._extended_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  -- Tell the server the capability of foldingRange,
  -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

return M

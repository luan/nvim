local util = require "lvim.util"

vim.diagnostic.config(require("lvim.config.lsp.diagnostics")["on"])

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end, {
  border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
  width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
  width = 60,
})

util.on_attach(function(client, buffer)
  require("lvim.config.lsp.keymaps").on_attach(client, buffer)
  require("lvim.config.lsp.inlayhints").on_attach(client, buffer)
  require("lvim.config.lsp.navic").on_attach(client, buffer)
end)

lvim.lsp = { servers = {} }
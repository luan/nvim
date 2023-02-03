local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.prettierd,
  formatting.prettier,
  formatting.stylua,
}
sources = tbl.merge_lists(sources, lvim.nullls.sources)

null_ls.setup {
  debug = false,
  sources = sources,
}

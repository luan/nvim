local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local sources = lvim.nullls.sources
if type(sources) == "function" then
  sources = sources()
end

null_ls.setup {
  debug = false,
  sources = sources,
}

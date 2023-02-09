local M = {}

local function module_name(opts)
  local name = string.lower(opts.name:gsub("%..*", ""))
  name = name:gsub("^n?vim%-", ""):gsub("%-n?vim$", ""):gsub("_", "-"):gsub("lspconfig", "lsp")
  return "lvim.config." .. name
end

function M.config(opts)
  local mod = module_name(opts)
  local m = require_safe(mod)
  if type(m) == "table" then
    m.setup()
  end
end

function M.tableize(spec)
  if type(spec) == "string" then
    spec = { spec }
  end
  return spec
end

function M.mapped(f)
  return function(specs)
    return vim.tbl_map(f, specs)
  end
end

function M.d(spec)
  spec = M.tableize(spec)
  spec["config"] = true
  return spec
end

function M.c(spec)
  spec = M.tableize(spec)
  spec["config"] = M.config
  return spec
end

function M.p(priority)
  return M.mapped(function(spec)
    spec = M.tableize(spec)
    spec["priority"] = priority
    return spec
  end)
end

M.l = M.mapped(function(spec)
  spec = M.tableize(spec)
  spec["lazy"] = false
  return spec
end)

return M

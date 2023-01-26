local M = {}
local Log = require "core.log"
local uv = vim.loop

--- @param on_attach fun(client, buffer)
M.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end
  })
end

M.get_highlight_value = function(group)
  local hl = vim.api.nvim_get_hl_by_name(group, true)
  local hl_config = {}
  for key, value in pairs(hl) do
    hl_config[key] = string.format("#%02x", value)
  end
  return hl_config
end


local function _assign(old, new, k)
  local otype = type(old[k])
  local ntype = type(new[k])
  -- print("hi")
  if (otype == "thread" or otype == "userdata") or (ntype == "thread" or ntype == "userdata") then
    vim.notify(string.format("warning: old or new attr %s type be thread or userdata", k))
  end
  old[k] = new[k]
end

local function _replace(old, new, repeat_tbl)
  if repeat_tbl[old] then
    return
  end
  repeat_tbl[old] = true

  local dellist = {}
  for k, _ in pairs(old) do
    if not new[k] then
      table.insert(dellist, k)
    end
  end
  for _, v in ipairs(dellist) do
    old[v] = nil
  end

  for k, _ in pairs(new) do
    if not old[k] then
      old[k] = new[k]
    else
      if type(old[k]) ~= type(new[k]) then
        Log:debug(
          string.format("Reloader: mismatch between old [%s] and new [%s] type for [%s]", type(old[k]), type(new[k]), k)
        )
        _assign(old, new, k)
      else
        if type(old[k]) == "table" then
          _replace(old[k], new[k], repeat_tbl)
        else
          _assign(old, new, k)
        end
      end
    end
  end
end

M.require_clean = function(m)
  package.loaded[m] = nil
  _G[m] = nil
  local _, module = pcall(require, m)
  return module
end

M.require_safe = function(mod)
  local status_ok, module = pcall(require, mod)
  if not status_ok then
    local trace = debug.getinfo(2, "SL")
    local shorter_src = trace.short_src
    local lineinfo = shorter_src .. ":" .. (trace.currentline or trace.linedefined)
    local msg = string.format("%s : skipped loading [%s]", lineinfo, mod)
    Log:debug(msg)
  end
  return module
end

M.reload = function(mod)
  if not package.loaded[mod] then
    return M.require_safe(mod)
  end

  local old = package.loaded[mod]
  package.loaded[mod] = nil
  local new = M.require_safe(mod)

  if type(old) == "table" and type(new) == "table" then
    local repeat_tbl = {}
    _replace(old, new, repeat_tbl)
  end

  package.loaded[mod] = old
  return old
end

M.get_cache_dir = function()
  local lvim_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not lvim_cache_dir then
    return vim.call("stdpath", "cache")
  end
  return lvim_cache_dir
end

-- recursive Print (structure, limit, separator)
local function r_inspect_settings(structure, limit, separator)
  limit = limit or 100 -- default item limit
  separator = separator or "." -- indent string
  if limit < 1 then
    print "ERROR: Item limit reached."
    return limit - 1
  end
  if structure == nil then
    io.write("-- O", separator:sub(2), " = nil\n")
    return limit - 1
  end
  local ts = type(structure)

  if ts == "table" then
    for k, v in pairs(structure) do
      -- replace non alpha keys with ["key"]
      if tostring(k):match "[^%a_]" then
        k = '["' .. tostring(k) .. '"]'
      end
      limit = r_inspect_settings(v, limit, separator .. "." .. tostring(k))
      if limit < 0 then
        break
      end
    end
    return limit
  end

  if ts == "string" then
    -- escape sequences
    structure = string.format("%q", structure)
  end
  separator = separator:gsub("%.%[", "%[")
  if type(structure) == "function" then
    -- don't print functions
    io.write("-- lvim", separator:sub(2), " = function ()\n")
  else
    io.write("lvim", separator:sub(2), " = ", tostring(structure), "\n")
  end
  return limit - 1
end

function M.generate_settings()
  -- Opens a file in append mode
  local file = io.open("lv-settings.lua", "w")

  -- sets the default output file as test.lua
  io.output(file)

  -- write all `lvim` related settings to `lv-settings.lua` file
  r_inspect_settings(lvim, 10000, ".")

  -- closes the open file
  io.close(file)
end

--- Returns a table with the default values that are missing.
--- either parameter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function M.apply_defaults(config, default_config)
  config = config or {}
  default_config = default_config or {}
  local new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), config)
  new_config = vim.tbl_deep_extend("keep", new_config, default_config)
  return new_config
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

function M.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

---Write data to a file
---@param path string can be full or relative to `cwd`
---@param txt string|table text to be written, uses `vim.inspect` internally for tables
---@param flag string used to determine access mode, common flags: "w" for `overwrite` or "a" for `append`
function M.write_file(path, txt, flag)
  local data = type(txt) == "string" and txt or vim.inspect(txt)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, data, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

---Copies a file or directory recursively
---@param source string
---@param destination string
function M.fs_copy(source, destination)
  local source_stats = assert(vim.loop.fs_stat(source))

  if source_stats.type == "file" then
    assert(vim.loop.fs_copyfile(source, destination))
    return
  elseif source_stats.type == "directory" then
    local handle = assert(vim.loop.fs_scandir(source))

    assert(vim.loop.fs_mkdir(destination, source_stats.mode))

    while true do
      local name = vim.loop.fs_scandir_next(handle)
      if not name then
        break
      end

      M.fs_copy(M.join_paths(source, name), M.join_paths(destination, name))
    end
  end
end

return M

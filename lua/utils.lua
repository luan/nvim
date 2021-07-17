local map = vim.api.nvim_set_keymap
local a = require('packer.async')
local async = a.sync

local M = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.map(modes, key, action, opts)
  opts = opts or {}
  modes:gsub(".", function(mode)
    map(mode, key, action, opts)
  end)
end

function M.has_module(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

function M.file_exists(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) or false
end

local path_separator = package.config:sub(1,1)
function M.path_join(paths)
  return table.concat(paths, path_separator)
end

function M.copy(source, destination)
  local luv = vim.loop
  local source_stats = luv.fs_stat(source)

  if source_stats and source_stats.type == 'file' then
    return luv.fs_copyfile(source, destination)
  end

  local handle = luv.fs_scandir(source)

  if type(handle) == 'string' then
    return false, handle
  end

  luv.fs_mkdir(destination, source_stats.mode)

  while true do
    local name, _ = luv.fs_scandir_next(handle)
    if not name then break end

    local new_name = M.path_join({source, name})
    local new_destination = M.path_join({destination, name})
    local success, msg = M.copy(new_name, new_destination)
    if not success then return success, msg end
  end

  return true
end

function M.check_dependencies(dependencies)
  async(function()
    local missing = {}

    for _, deps in pairs(dependencies) do
      if type(deps) ~= 'table' then
        deps = {deps}
      end

      local found = false
      for _, dep in pairs(deps) do
        if vim.fn.executable(dep) == 1 then
          found = true
          break
        end
      end

      if not found then
        table.insert(missing, deps[1])
      end
    end

    if #missing > 0 then
      local missing_string = table.concat(missing, ", ")
      vim.cmd([[
      echohl ErrorMsg | echomsg 'Missing dependencies (]] .. missing_string .. [[) detected. Please refer to the README for more information on how to install them.' | echohl None]]
      )
    end
  end)()
end

return M

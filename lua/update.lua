local jobs = require 'packer.jobs'
local a = require 'packer.async'
local result = require 'packer.result'
local await = a.wait
local async = a.sync
local fmt = string.format
local check_dependencies = require('utils').check_dependencies

check_dependencies({'curl', 'npm', 'rg', {'fd', 'fdfind'}})

local function printerr(msg)
    error(fmt('echoerr "%s"', string.gsub(msg, "\n", " ")))
end

local function warn(msg)
    vim.schedule(function()
      vim.cmd(fmt("echohl WarningMsg | echomsg '%s' | echohl None", msg))
    end)
end

local function async_command(cmd, ignore_error)
  return async(function ()
    local r = result.ok()
    local opts = { capture_output = true, cwd = CONFIG_PATH }
    r
      :and_then(await, jobs.run(cmd, opts))
      :map_err(function(err)
        if not ignore_error then
          printerr(fmt('Failed to update config. %s: %s', cmd, err.output.data.stderr[1]))
        end
        return nil
      end)
      :map_ok(function(ok)
        return ok.output.data.stdout[1]
      end)

    return r.ok
  end)
end

local function remote_version()
  return vim.fn.system('git rev-parse @{u}')
end

local function local_version()
  return vim.fn.system('git rev-parse @')
end

local function merge_base()
  return vim.fn.system('git merge-base @ "@{u}"')
end

local function update_check()
  return async(function()
    await(async_command('git remote update'))
    await(async_command('git update-index -q --refresh'))
    local has_local_changes = await(async_command('git diff-index --quiet HEAD --', true)) == nil

    if has_local_changes then
      warn('Local changes detected. If these are user preferences, consider moving them to your user settings.')
      return -1
    elseif local_version() == remote_version() then
      -- up to date
      return 0
    elseif local_version() == merge_base() then
      warn('There is a new version of the nvim config available. Run :ConfigUpdate to update to the latest.')
      return 1
    elseif remote_version() == merge_base() then
      warn('Local commits detected. You may want to push / send a PR / move your changes to user settings?')
      return -1
    end
    return -1
  end)
end

local M = {}

function M.status()
  if local_version() ~= remote_version() then
    return " update available!"
  end
  return ""
end

function _G.config_update()
  async(function()
    local has_update = await(update_check())
    if has_update == 0 then
      return
    elseif has_update == -1 then
      printerr('Local changes detected. Update aborted!')
      return
    end

    await(async_command('git merge' .. remote_version()))
    package.loaded['plugins'] = nil
    require('plugins').sync()
  end)()
end

async(function()
  await(update_check())
end)()

vim.cmd("command! ConfigUpdate call v:lua.config_update()")

return M

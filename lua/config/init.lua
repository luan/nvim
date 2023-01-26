local utils = require "core.util"
local Log = require "core.log"

local M = {}
local user_config_dir = get_config_dir()
local user_config_file = utils.join_paths(user_config_dir, "config.lua")

---Get the full path to the user configuration file
---@return string
function M:get_user_config_path()
  return user_config_file
end

function M:init()
  lvim = vim.deepcopy(require "config.defaults")

  require("lvim.keymappings").load_defaults()

  local builtins = require "core.builtins"
  builtins.config { user_config_file = user_config_file }

  -- local settings = require "config.settings"
  -- settings.load_defaults()

  local autocmds = require "core.autocmds"
  autocmds.load_defaults()

  local lsp_config = require "config.lsp.config"
  lvim.lsp = vim.deepcopy(lsp_config)

  luanvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }

  luanvim.builtin.bigfile = {
    active = true,
    config = {},
  }
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = reload "core.autocmds"
  config_path = config_path or self:get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      vim.notify_once(
        string.format("User-configuration not found. Creating an example configuration in %s", config_path)
      )
      local config_name = vim.loop.os_uname().version:match "Windows" and "config_win" or "config"
      local example_config = join_paths(CONFIG_PATH, "utils", "installer", config_name .. ".example.lua")
      vim.fn.mkdir(user_config_dir, "p")
      vim.loop.fs_copyfile(example_config, config_path)
    end
  end

  Log:set_level(luanvim.log.level)

  autocmds.define_autocmds(lvim.autocommands)

  vim.g.mapleader = (luanvim.leader == "space" and " ") or luanvim.leader

  -- reload("lvim.keymappings").load(lvim.keys)

  if luanvim.transparent_window then
    autocmds.enable_transparent_mode()
  end

  if luanvim.reload_config_on_save then
    autocmds.enable_reload_config_on_save()
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  vim.schedule(function()
    -- reload("lvim.utils.hooks").run_pre_reload()

    M:load()

    reload("core.autocmds").configure_format_on_save()

    -- local plugins = reload "lvim.plugins"
    -- local plugin_loader = reload "lvim.plugin-loader"

    -- plugin_loader.reload { plugins, lvim.plugins }
    -- reload("lvim.core.theme").setup()
    -- reload("lvim.utils.hooks").run_post_reload()
  end)
end

return M

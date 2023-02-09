local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

local icons = require "lvim.core.icons"

notify.setup {
  -- Animation style (see below for details)
  stages = "fade",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "compact",

  -- Default timeout for notifications
  timeout = 1000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "Normal",

  -- Minimum width for notification windows
  minimum_width = 10,
}

vim.notify = notify

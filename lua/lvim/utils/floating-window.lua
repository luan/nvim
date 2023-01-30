local Popup = require "nui.popup"
local event = require("nui.utils.autocmd").event

local M = {}

function M.new()
  local popup = Popup {
    enter = true,
    focusable = true,
    border = {
      style = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
    },
    position = {
      col = "50%",
      row = "20%",
    },
    relative = "editor",
    size = {
      width = "50%",
      height = "40%",
    },
    zindex = 1,
  }

  popup:mount()

  popup:map("n", "q", function()
    popup:unmount()
  end)
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)
end

return M

local dashboard = require "dashboard"

local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣤⣴⣶⣶⣶⣾⣾⣿⣿⣿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⣿⣶⣶⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣶⣿⡿⠿⠿⠿⠿⠿⠻⠿⠿⠿⠿⠿⣿⣿⣿⣷⣶⣶⣶⣦⣤
⣿⣿⣯⣽⣿⣿⡋⣣⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠛⠛⠿⣿⣿⣶⣶⣤⣤⣤⣴⣶⣶⣿⣿⠿⠟⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡴⣉⣿⣿⣿⣭⣽⣿
⠹⣿⣿⣿⡿⠽⠛⠛⠛⠻⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⠿⠛⠛⠛⠫⢽⣿⣿⣿⡟
⠀⢻⣿⣿⠁⠀⠀⠀⠀⠀⠀⠙⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡿⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⠟⠁⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀
⠀⠘⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⡇⠀
⠀⠀⢹⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡿⠀⠀⠀⠀⢻⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣻⣿⠀⠀
⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠃⠀⠀⠀⠀⠈⢿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡏⠀⠀
⠀⠀⠀⢿⣗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡏⠀⠀⠀⠀⠀⠀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠃⠀⠀
⠀⠀⠀⠘⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡟⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡿⠀⠀⠀
⠀⠀⠀⠀⠘⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠃⠀⠀⠀
⠀⠀⠀⠀⠀⠘⢿⣦⡄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠿⢶⣶⣤⣤⣤⣤⣤⣤⣤⣤⣤⣴⠶⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⢶⣶⣤⣤⣤⣤⣤⣤⣤⣤⣴⣶⠾⠿⠛⠋⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠋⠉⠉⠉⠁⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

local config = {
  theme = "doom",
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  config = {
    ---@diagnostic disable-next-line: missing-parameter
    header = vim.split("\n\n" .. logo, "\n"), --your header
    center = {
      {
        icon = "   ",
        icon_hl = "DashboardRecent",
        desc = "Recent Files                                    ",
        -- desc_hi = "String",
        key = "r",
        key_hl = "DashboardRecent",
        action = "Telescope oldfiles",
      },
      {
        icon = "   ",
        icon_hl = "DashboardSession",
        desc = "Load session",
        key = "s",
        key_hl = "DashboardSession",
        action = "lua require('resession').load()",
      },
      {
        icon = "   ",
        icon_hl = "DashboardSession",
        desc = "Last session",
        key = "l",
        key_hl = "DashboardSession",
        action = [[lua require("resession").load(require("lvim.utils").get_session_name(), { dir = "dirsession", silence_errors = true })]],
      },
      {
        icon = "   ",
        icon_hl = "DashboardProject",
        desc = "Find Project",
        key = "f",
        key_hl = "DashboardProject",
        action = "Telescope projects",
      },
      {
        icon = "   ",
        icon_hl = "DashboardConfiguration",
        desc = "Configuration",
        key = "c",
        key_hl = "DashboardConfiguration",
        action = "e " .. require("lvim.utils.modules").user_config_file(),
      },
      {
        icon = "   ",
        icon_hl = "DashboardQuit",
        desc = "Quit Neovim",
        -- desc_hi = "String",
        key = "q",
        key_hl = "DashboardQuit",
        action = "qa",
      },
    },
    footer = {},
  },
}

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    config.config.footer = {
      "",
      " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms",
    }
    dashboard.setup(config)
  end,
})

dashboard.setup(config)

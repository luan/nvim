local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local theme = require "alpha.themes.dashboard"
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
---@diagnostic disable-next-line: missing-parameter
theme.section.header.val = vim.split(logo, "\n")

theme.section.buttons.val = {
  theme.button("r", "  Recently files", ":Telescope oldfiles<CR>"),
  theme.button("f", "  Find files", ":Telescope find_files<CR>"),
  theme.button("p", "  Find projects", ":Telescope projects<CR>"),
  theme.button("s", "  Load session", ':lua require("resession").load()<CR>'),
  theme.button(
    "l",
    "  Load last session",
    [[:lua require("resession").load(require("lvim.utils").get_session_name(), { dir = "dirsession", silence_errors = true })<CR>]]
  ),
  theme.button("c", "  Configuration", ":e " .. require("lvim.utils.modules").user_config_file() .. "<CR>"),
  theme.button("q", "  Quit Neovim", ":qa<CR>"),
}
-- theme.section.buttons.type = "button"

theme.section.footer.opts.hl = "AlphaFooter"
theme.section.header.opts.hl = "AlphaHeader"
theme.section.buttons.opts.hl = "AlphaButton"
theme.opts.layout[1].val = 1

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
end

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.cmd [[
        setlocal showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
        setlocal laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
      ]]
  end,
})

alpha.setup(theme.opts)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    theme.section.footer.val = " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})

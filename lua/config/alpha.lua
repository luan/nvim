local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local logo = [[
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⠿⣋⣭⢍⣩⣝⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⡿⣿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⣫⣶⣿⣟⣵⣿⣿⣿⣷⣝⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⡿⣣⣶⣶⣄⡲⣬⣍⡛⠿⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⢀⣴⢟⣵⣿⣿⣿⢏⣾⣿⡿⣫⣷⣿⣿⡮⡻⣿⣿⣷⣦⡀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣦⡄⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⠟⣴⣿⣿⣿⣿⣿⣎⠻⣿⣷⣦⣍⡛⠿⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⣠⢟⣵⣿⣿⣿⣿⡏⣾⣿⢟⣾⣿⣿⣿⣿⣷⣿⣮⠻⣿⣿⣿⢦⡀⣠⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⢀⣴⣿⣿⣿⢋⣾⣿⣿⣿⣿⣿⣿⣿⣷⡝⣿⣿⣿⣿⣷⣬⣙⠻⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⡼⣣⣿⣿⣿⣿⣿⣿⢸⣿⡟⣾⣿⣿⣿⣿⣿⣿⣫⣾⣧⣬⣽⣾⣷⣭⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⢀⣀⣴⣿⣿⣿⡿⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⢿⣿⣿⣿⣿⣿⣷⣮⣝⠷⣦⡀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⢀⡾⣱⣿⣿⣿⣿⣿⣿⡏⣿⣿⡷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣣⣶⣿⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⣿⣿⣿⣿⣿⣿⣿⣿⣷⣬⡻⣦⡀⠀⠀⠀⠀⠀
  ⠀⠀⠀⡼⣱⣿⠿⠿⠻⠿⣿⣿⡇⣿⣿⢧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣵⣶⡎⣿⣿⠿⢟⣛⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡸⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣎⢻⡄⠀⠀⠀⠀
  ⠀⠀⠀⣇⠟⠁⠀⠀⠀⠀⠀⠙⢧⢿⣇⣿⡏⠀⢹⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢻⠀⠀⢨⣿⣿⣿⡿⣟⣙⣻⠿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣏⠉⠉⠉⠉⠉⠛⠛⢧⢹⠟⠉⠀⠀⠀⠀⠀⠈⠛⢿⡎⣧⠀⠀⠀⠀
  ⠀⠀⠀⠋⠀⠀⠀⠀⠀⠀⠀⠀⠈⠸⠃⣿⣷⣄⡈⠀⣻⣿⣿⣿⣿⣿⣿⣿⣿⣤⣤⣤⣴⣿⣿⣿⡿⣴⣿⣿⣿⣿⣮⡹⣿⣿⣿⡝⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠙⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠽⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣞⢿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣬⣛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⢀⣼⣿⣿⣿⣿⣿⣿⢃⣿⣿⣿⣿⣿⡎⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣶⣯⣽⡟⠛⠛⠛⠛⠉⠁⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⠏⣼⣿⣿⣿⣿⣿⠃⠻⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⡏⣼⣿⣿⣿⣿⣿⠇⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⢸⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⣼⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⠉⠿⠿⠍⠻⠿⠍⠃⠀⠀⠃⠹⠿⠇⢨⠿⠻⠀⠛⠁⠀⠃⠘⠛⠈⠛⠛⠀⠁⠀⠀⠀⠀⢸⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣄⣀⣀⠀⠤⣤⠤⠤⠤⠤⠤⢤⣤⣤⣤⣤⣀⣀⣀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡐⢚⣫⣭⢄⣶⣾⣿⢋⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠛⠻⠿⠿⠿⣿⡿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⣵⣿⣿⡏⣾⠿⠛⠛⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠋⠉⠉⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

dashboard.section.header.val = vim.split(logo, '\n')
dashboard.section.buttons.val = {
  dashboard.button("r", "  Recently files", ":Telescope oldfiles <CR>"),
  dashboard.button("s", "  Find Session", ":SearchSession<CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("i", "  Configuration", ":e /home/loc/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}


dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "MoreMsg"
dashboard.opts.layout[1].val = 1

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
end

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.cmd([[
        setlocal showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
        setlocal laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
      ]])
  end,
})

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})

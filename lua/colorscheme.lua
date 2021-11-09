if not(vim.g.lualine_theme) then
    vim.g.lualine_theme = 'onedark'
end

if not(vim.g.config_colorscheme) then
    vim.g.config_colorscheme = 'onedark'
end

vim.cmd([[silent! colorscheme ]] .. vim.g.config_colorscheme)


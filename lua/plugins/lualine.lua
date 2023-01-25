local function config()
    require('lualine').setup({
        options = {
            theme = vim.g.lualine_theme,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = {
                'filetype',
                {
                    'filename',
                    file_status = true,
                    path = 1,
                },
            },
            lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, 'encoding', 'fileformat' },
            lualine_y = { 'progress' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                },
            },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
    })
end

return {
    'hoob3rt/lualine.nvim',
    config = config,
}

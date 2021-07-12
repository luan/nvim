if not(vim.g.lualine_theme) then
    vim.g.lualine_theme = 'neon'
end

require('lualine').setup {
    options = {
        theme = vim.g.lualine_theme,
        section_separators = {'', ''},
        component_separators = {'', ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
            'filetype',
            {
                'filename',
                file_status = true,
                path = 1,
            },
        },
        lualine_x = {'diagnostics', 'encoding', 'fileformat'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
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
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
}

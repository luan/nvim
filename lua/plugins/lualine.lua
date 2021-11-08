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
        lualine_x = {{ 'diagnostics', sources = {'nvim_lsp'}}, 'encoding', 'fileformat'},
        lualine_y = {'progress'},
        lualine_z = {'location', require('update').status }
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

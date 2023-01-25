return {
    'folke/lsp-colors.nvim',
    'rafamadriz/neon',
    'navarasu/onedark.nvim',
    'sainnhe/gruvbox-material',
    'RRethy/nvim-base16',
    "folke/tokyonight.nvim",
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local monokai = require("monokai-pro")
            monokai.setup({
                transparent_background = true,
                italic_comments = true,
                filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
                inc_search = "underline", -- underline | background
                background_clear = {},
                diagnostic = {
                    background = true,
                },
                plugins = {
                    bufferline = {
                        underline_selected = true,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = "pro", -- default | pro
                    },
                },
            })
            monokai.load()
        end,
    },
}

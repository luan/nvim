local has_module = require('utils').has_module

return {
    -- All the lua functions I don't want to write twice.
    'nvim-lua/plenary.nvim',
    -- drop in replacement for filetype.vim
    'nathom/filetype.nvim',

    {
        'rcarriga/nvim-notify',
        config = function() vim.notify = require('notify') end,
    },

    -- colorshcemes
    'rafamadriz/neon',
    'navarasu/onedark.nvim',
    'sainnhe/gruvbox-material',
    -- these don't switch the whole background sometimes...
    'RRethy/nvim-base16',

    'kyazdani42/nvim-web-devicons',

    'nvim-lua/popup.nvim',

    {
        'antoinemadec/FixCursorHold.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            vim.g.cursorhold_updatetime = 100
        end,
    },

    'moll/vim-bbye',

    'lukas-reineke/lsp-format.nvim',
    'neovim/nvim-lspconfig',
    'folke/lsp-colors.nvim',
    'williamboman/nvim-lsp-installer',
    'folke/trouble.nvim',
    'onsails/lspkind-nvim',
    'ray-x/lsp_signature.nvim',
    'nvim-lua/lsp-status.nvim',
    'jose-elias-alvarez/null-ls.nvim',

    'p00f/nvim-ts-rainbow',
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',

    {
        'windwp/nvim-autopairs',
        config = function() require('plugins.autopairs') end,
    },

    {
        'RRethy/nvim-treesitter-endwise',
        config = function()
            require('nvim-treesitter.configs').setup {
                endwise = {
                    enable = true,
                },
            }
        end
    },

    {
        'folke/which-key.nvim',
        config = true,
    },

    'jghauser/mkdir.nvim',

    {
        'ray-x/go.nvim',
        config = function()
            require('go').setup({
                lsp_keymaps = false,
            })
            vim.api.nvim_exec([[
                    autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
                ]], false)
        end,
    },

    {
        'hrsh7th/vim-vsnip',
        dependencies = {
            'hrsh7th/vim-vsnip-integ',
            'rafamadriz/friendly-snippets',
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g.indent_blankline_char = '▏'

            vim.g.indent_blankline_filetype_exclude = { 'help', 'terminal', 'dashboard', 'nofile' }
            vim.g.indent_blankline_buftype_exclude = { 'terminal' }

            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_show_first_indent_level = false
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = true
    },

    'kevinhwang91/nvim-bqf',

    -- file explorer

    'windwp/nvim-spectre',
    {
        'karb94/neoscroll.nvim',
        config = true,
    },
    'sindrets/diffview.nvim',

    -- generic (non lua) plugins
    'AndrewRadev/splitjoin.vim',
    'bronson/vim-trailing-whitespace',
    'junegunn/vim-easy-align',
    'kopischke/vim-fetch',
    'kopischke/vim-stay',
    'liuchengxu/vista.vim',
    'machakann/vim-swap',
    'matze/vim-move',
    'mbbill/undotree',
    'mg979/vim-visual-multi',
    'romainl/vim-qf',
    'tommcdo/vim-exchange',
    'benmills/vimux',
    'skywind3000/asyncrun.vim',
    'sk1418/Join',

    {
        'mhinz/vim-grepper',
        config = function()
            vim.g.grepper = {
                tools = { 'rg', 'git' },
                simple_prompt = 0,
                prompt_mapping_tool = '<F10>',
                prompt_mapping_dir = '<F11>',
                prompt_mapping_side = '<F12>',
            }
        end,
    },

    -- thanks tpope
    'tpope/vim-abolish',
    'tpope/vim-eunuch',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-rhubarb',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',

    -- languages
    {
        'numirias/semshi',
        bvuild = ':UpdateRemotePlugins',
    },
    {
        'tpope/vim-markdown',
        ft = 'markdown',
    },
    {
        'keith/rspec.vim',
        'tpope/vim-bundler',
        'tpope/vim-rails',
        'tpope/vim-rake',
        'vim-ruby/vim-ruby',
        ft = { 'ruby', 'rake' }
    },
    {
        'tpope/vim-cucumber',
        ft = 'cucumber',
    },
    'cappyzawa/starlark.vim',
    {
        'mattn/emmet-vim',
        config = function()
            vim.g.user_emmet_leader_key = '<leader>e'
            vim.g.user_emmet_mode = 'nv'
        end,
    },
}

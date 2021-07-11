require('packer-init')

return require('packer').startup {
    function(use)
        -- Packer can manage itself as an optional plugin
        use 'wbthomason/packer.nvim'

        use 'nvim-lua/plenary.nvim'

        use 'rafamadriz/neon'
        use 'RRethy/nvim-base16'

        use "kyazdani42/nvim-web-devicons"
        use {
            'hoob3rt/lualine.nvim',
            config = function() require('plugins.lualine') end,
        }

        use 'nvim-lua/popup.nvim'

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
            },
            config = function() require('plugins.telescope') end,
        }

        use {
            'junegunn/fzf.vim',
            require = {'junegunn/fzf', run = vim.fn['fzf#install'] },
            setup = function() vim.g.fzf_command_prefix = 'FZF' end,
            config = function() require('plugins.fzf') end,
        }

        use 'neovim/nvim-lspconfig'
        use 'kabouzeid/nvim-lspinstall'

        use {
            "hrsh7th/nvim-compe",
            config = function() require('plugins.compe') end,
        }

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function() require('plugins.trouble') end,
        }

        use 'folke/lsp-colors.nvim'

        use {
            'glepnir/lspsaga.nvim',
            config = function() require('plugins.lspsaga') end,
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                "nvim-treesitter/playground",
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
            config = function() require('plugins.treesitter') end,
        }

        use {
            'onsails/lspkind-nvim',
            config = function() require('lspkind').init{} end,
        }

        use {
            "folke/which-key.nvim",
            config = function() require("which-key").setup{} end
        }

        use {
            'jghauser/mkdir.nvim',
            config = function() require('mkdir') end,
        }

        use {
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim'
            },
            config = function() require('plugins.gitsigns') end,
        }

        use 'ray-x/go.nvim'

        use {
            'glepnir/dashboard-nvim',
            config = function() require('plugins.dashboard') end,
        }

        use 'famiu/bufdelete.nvim'

        use {
            'hrsh7th/vim-vsnip',
            requires = {
                'hrsh7th/vim-vsnip-integ',
                'rafamadriz/friendly-snippets',
            },
        }

        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                      vim.g.indent_blankline_char = "▏"

                      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "nofile"}
                      vim.g.indent_blankline_buftype_exclude = {"terminal"}

                      vim.g.indent_blankline_show_trailing_blankline_indent = false
                      vim.g.indent_blankline_show_first_indent_level = false
            end,
        }
        use {
            'b3nj5m1n/kommentary',
            config = function()
                require('kommentary.config').configure_language("default", {
                    prefer_single_line_comments = true,
                })
            end,
        }

        use 'kevinhwang91/nvim-bqf'

        -- file explorer
        use {
            'tamago324/lir.nvim',
            config = function() require('plugins.lir') end,
        }

        use 'windwp/nvim-spectre'
        use {
            'karb94/neoscroll.nvim',
            config = function() require('neoscroll').setup() end,
        }
        use 'sindrets/diffview.nvim'
        use {
            'rmagatti/auto-session',
            config = function() require('auto-session').setup() end,
        }
        use {
            "Pocco81/TrueZen.nvim",
            config = function() require('plugins/truezen') end,
        }

        -- generic (non lua) plugins
        use 'AndrewRadev/splitjoin.vim'
        use 'bronson/vim-trailing-whitespace'
        use 'junegunn/vim-easy-align'
        use 'kopischke/vim-fetch'
        use 'kopischke/vim-stay'
        use 'liuchengxu/vista.vim'
        use 'machakann/vim-swap'
        use 'matze/vim-move'
        use 'mbbill/undotree'
        use 'mg979/vim-visual-multi'
        use 'romainl/vim-qf'
        use 'rstacruz/vim-closer'
        use 'tommcdo/vim-exchange'

        use {
            'trsdln/vim-grepper',
            config = function()
                vim.g.grepper = {
                    tools = {'rg', 'git'},
                    simple_prompt = 0,
                    prompt_mapping_tool = '<F10>',
                    prompt_mapping_dir = '<F11>',
                    prompt_mapping_side = '<F12>',
                }
            end,
        }
        use {
            'haya14busa/incsearch.vim',
            config = function() require('plugins.incsearch') end,
        }

        -- thanks tpope
        use 'tpope/vim-abolish'
        use 'tpope/vim-endwise'
        use 'tpope/vim-eunuch'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-repeat'
        use 'tpope/vim-rhubarb'
        use 'tpope/vim-sleuth'
        use 'tpope/vim-surround'
        use 'tpope/vim-unimpaired'
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}

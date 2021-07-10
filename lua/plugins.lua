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

        use 'famiu/nvim-reload'

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
            'windwp/nvim-autopairs',
            requires = {
                'windwp/nvim-ts-autotag',
            },
            config = function() require('plugins.autopairs') end,
        }

        use {
            'hrsh7th/vim-vsnip',
            requires = {
                'hrsh7th/vim-vsnip-integ',
                'rafamadriz/friendly-snippets',
            },
        }
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}

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
            'junegunn/vim-peekaboo',
            config = function() require('plugins.peekaboo') end,
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
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}

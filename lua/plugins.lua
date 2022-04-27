require('packer-init')
local packer = require('packer')
local has_module = require('utils').has_module

vim.cmd([[
augroup config#update
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]])

packer.startup {
    function(use)
        if has_module('user.plugins') then
            local user_plugins = require('user.plugins')
            if user_plugins and user_plugins.plugins then
                user_plugins.plugins(use)
            end
        end

        -- Packer can manage itself as an optional plugin
        use 'wbthomason/packer.nvim'

        -- Speed up loading Lua modules in Neovim to improve startup time.
        use {
            'lewis6991/impatient.nvim',
            config = function() require('impatient') end,
        }

        -- drop in replacement for filetype.vim
        use 'nathom/filetype.nvim'

        use 'nvim-lua/plenary.nvim'
        use {
            'rcarriga/nvim-notify',
            config = function() vim.notify = require('notify') end,
        }

        use 'rafamadriz/neon'
        use 'navarasu/onedark.nvim'
        use 'sainnhe/gruvbox-material'

        -- these don't switch the whole background sometimes...
        use 'RRethy/nvim-base16'

        use 'kyazdani42/nvim-web-devicons'
        use {
            'hoob3rt/lualine.nvim',
            config = function() require('plugins.lualine') end,
        }

        use 'nvim-lua/popup.nvim'

        use {
            'antoinemadec/FixCursorHold.nvim',
            event = { 'BufRead', 'BufNewFile' },
            config = function()
                vim.g.cursorhold_updatetime = 100
            end,
        }

        use 'moll/vim-bbye'

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
                {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
            },
            config = function() require('plugins.telescope') end,
        }

        use {
            'junegunn/fzf.vim',
            requires = {'junegunn/fzf', run = vim.fn['fzf#install'] },
            setup = function() vim.g.fzf_command_prefix = 'FZF' end,
            config = function() require('plugins.fzf') end,
        }

        use {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
        }

        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/vim-vsnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/cmp-calc",
            },
            config = function() require('plugins/completion') end,
        }

        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require('plugins.trouble') end,
        }

        use 'folke/lsp-colors.nvim'

        local saga_branch = 'main'
        if vim.version().major == 0 and vim.version().minor == 5 and vim.version().patch == 1 then
            saga_branch = 'nvim51'
        end
        use {
            'tami5/lspsaga.nvim',
            branch = saga_branch,
            config = function() require('plugins.lspsaga') end,
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                },
            },
            config = function() require('plugins.treesitter') end,
        }

        use {
            'onsails/lspkind-nvim',
            config = function() require('lspkind').init{} end,
        }

        use {
            'folke/which-key.nvim',
            config = function() require('which-key').setup{} end
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
            'goolord/alpha-nvim',
            config = function() require('plugins.dashboard') end,
        }

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
                      vim.g.indent_blankline_char = '▏'

                      vim.g.indent_blankline_filetype_exclude = {'help', 'terminal', 'dashboard', 'nofile'}
                      vim.g.indent_blankline_buftype_exclude = {'terminal'}

                      vim.g.indent_blankline_show_trailing_blankline_indent = false
                      vim.g.indent_blankline_show_first_indent_level = false
            end,
        }
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        use 'kevinhwang91/nvim-bqf'

        -- file explorer
        use {
            'tamago324/lir.nvim',
            requires = {'tamago324/lir-git-status.nvim'},
            config = function() require('plugins.lir') end,
        }

        use 'windwp/nvim-spectre'
        use {
            'karb94/neoscroll.nvim',
            config = function() require('neoscroll').setup() end,
        }
        use 'sindrets/diffview.nvim'
        use {
            'Pocco81/TrueZen.nvim',
            config = function() require('plugins/truezen') end,
        }
        use {
            'rcarriga/vim-ultest',
            requires = { 'vim-test/vim-test' },
            run = ':UpdateRemotePlugins',
            config = function() require('plugins/test') end,
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
        use 'benmills/vimux'
        use 'sk1418/Join'

        use {
            'mhinz/vim-grepper',
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

        -- languages
        use {
            'numirias/semshi',
            run = ':UpdateRemotePlugins',
            -- ft = 'python' -- doesn't work
        }
        use {
            'tpope/vim-markdown',
            ft = 'markdown',
        }
        use 'keith/rspec.vim'
        use {
            'tpope/vim-bundler',
            'tpope/vim-rails',
            'tpope/vim-rake',
            ft = {'ruby', 'rake'}
        }
        use {
            'tpope/vim-cucumber',
            ft = 'cucumber',
        }
        use 'PotatoesMaster/i3-vim-syntax'
        use 'cappyzawa/starlark.vim'
        use {
            'mattn/emmet-vim',
            config = function()
                vim.g.user_emmet_leader_key = '<leader>e'
                vim.g.user_emmet_mode = 'nv'
            end,
        }
    end,
}

packer.install()
return packer

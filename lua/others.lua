return {
    -- drop in replacement for filetype.vim
    'nathom/filetype.nvim',

    'lukas-reineke/lsp-format.nvim',
    'folke/trouble.nvim',
    'onsails/lspkind-nvim',

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
}

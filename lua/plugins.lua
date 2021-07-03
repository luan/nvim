require('packer-init')

return require('packer').startup({function()
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    use "siduck76/nvim-base16.lua"

    use "kyazdani42/nvim-web-devicons"
    use {
        'glepnir/galaxyline.nvim',
        config = function() require('plugins.galaxyline') end,
    }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

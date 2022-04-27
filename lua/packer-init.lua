local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then return end

packer.init {
    git = {
        clone_timeout = 300,
        subcommands = {
            update = "pull --ff-only --progress --rebase=true",
        },
    },
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    }
}

-- Auto compile when there are changes in plugins.lua
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

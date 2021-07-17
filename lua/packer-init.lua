local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    vim.cmd "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then return end

packer.init {
    git = {clone_timeout = 300},
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    }
}

-- Auto compile when there are changes in plugins.lua
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

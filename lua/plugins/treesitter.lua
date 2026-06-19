return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          rn = "rune",
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").rune = {
            install_info = {
              url = "https://github.com/zhuhaow/tree-sitter-rune",
              revision = "91dd6fa73fb14a02c728601ae0a853238625b627",
            },
            tier = 2,
          }
        end,
      })
    end,
    opts = {
      ensure_installed = { "rune" },
    },
  },
}

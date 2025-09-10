return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          procMacro = {
            ignored = {
              ["async-trait"] = vim.NIL,
            },
          },
        },
      },
    },
  },
}

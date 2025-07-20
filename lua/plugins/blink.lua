return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.appearance = opts.appearance or {}
    opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
    opts.sources = {
      -- add lazydev to your completion providers
      default = { "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
      },
    }
    opts.keymap = {
      preset = "enter",
      ["<C-f>"] = false,
      ["<C-y>"] = { "select_and_accept" },
      ["<M-;>"] = { "select_and_accept" },
    }
  end,
}

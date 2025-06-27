return {
  -- Add Swift LSP configuration using sourcekit-lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("buildServer.json")(fname)
              or require("lspconfig.util").root_pattern("*.xcodeproj", "*.xcworkspace")(fname)
              or require("lspconfig.util").root_pattern("Package.swift")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
          end,
        },
      },
    },
  },

  -- Add Swift treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "swift",
      })
    end,
  },
}


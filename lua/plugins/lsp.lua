return {
  -- Add Swift LSP configuration using sourcekit-lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Configure diagnostics display
      diagnostics = {
        virtual_text = false, -- Disable virtual text
      },
      -- Configure inlay hints with error handling
      inlay_hints = {
        enabled = true,
        exclude_filetypes = { "vue", "markdown", "text", "help" },
      },

      setup = {
        sourcekit = function(_, opts)
          vim.lsp.enable("sourcekit")
          return true
        end,
      },

      servers = {
        lua_ls = {
          settings = {
            Lua = {
              -- runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                useGitIgnore = true,
              },
              telemetry = { enable = false },
            },
          },
        },

        neocmake = {
          init_options = {
            format = {
              enable = false,
            },
            lint = {
              enable = false,
            },
            scan_cmake_in_package = true, -- default is true
          },
        },

        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = false,
                unusedwrite = false,
                shadow = false,
              },
              staticcheck = false,
            },
          },
        },

        sourcekit = {
          mason = false,
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("buildServer.json")(fname)
              or require("lspconfig.util").root_pattern("*.xcodeproj", "*.xcworkspace")(fname)
              or require("lspconfig.util").root_pattern("Package.swift")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
          end,
          settings = {
            sourcekit = {
              formatting = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}

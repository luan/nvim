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
      -- Setup function to configure inlay hints safely
      setup = {
        ["*"] = function(server, opts)
          -- Safe wrapper for inlay hints to prevent column range errors
          if server.server_capabilities and server.server_capabilities.inlayHintProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
              buffer = 0,
              callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                local filetype = vim.bo[bufnr].filetype

                -- Skip problematic filetypes
                local excluded_filetypes = { "vue", "markdown", "text", "help", "neo-tree" }
                for _, ft in ipairs(excluded_filetypes) do
                  if filetype == ft then
                    return
                  end
                end

                -- Safe inlay hints refresh with error handling
                local ok, _ = pcall(function()
                  if vim.lsp.inlay_hint and vim.api.nvim_buf_is_valid(bufnr) then
                    -- Check if buffer has valid content and cursor position
                    local line_count = vim.api.nvim_buf_line_count(bufnr)
                    if line_count > 0 then
                      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                  end
                end)
                if not ok then
                  -- Silently disable inlay hints for this buffer if errors occur
                  vim.schedule(function()
                    if vim.lsp.inlay_hint then
                      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                    end
                  end)
                end
              end,
            })
          end
        end,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
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
              enable = true,
            },
            scan_cmake_in_package = true, -- default is true
          },
        },

        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
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

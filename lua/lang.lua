local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local opts = {
    root_dir = vim.loop.cwd,
    capabilities = capabilities,
  }

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = {"vim"}
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        },
        telemetry = {
          enable = false
        }
      }
    }
  elseif server.name == 'gopls' then
    opts.settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = true,
      },
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

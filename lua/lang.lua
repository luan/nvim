local lspinstall = require('lspinstall')

local jedi_config = require("lspinstall/util").extract_config("jedi_language_server")
jedi_config.default_config.cmd[1] = "./venv/bin/jedi-language-server"

require('lspinstall/servers').jedi = vim.tbl_extend('error', jedi_config, {
  install_script = [[
  python3 -m venv ./venv
  ./venv/bin/pip3 install --upgrade pip
  ./venv/bin/pip3 install --upgrade jedi-language-server
  ]]
})

lspinstall.setup()
local servers = lspinstall.installed_servers()

local function setup_servers()
    local lspconf = require('lspconfig')

    for _, lang in pairs(servers) do
        if lang == "lua" then
            lspconf[lang].setup {
                root_dir = vim.loop.cwd,
                settings = {
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
            }
        else
            lspconf[lang].setup {
                root_dir = vim.loop.cwd
            }
        end
    end
end

setup_servers()


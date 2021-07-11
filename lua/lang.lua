local lspinstall = require('lspinstall')
lspinstall.setup()
local servers = lspinstall.installed_servers()

local function setup_servers()
    local lspconf = require('lspconfig')

    for _, lang in pairs(servers) do
        if lang ~= "lua" then
            lspconf[lang].setup {
                root_dir = vim.loop.cwd
            }
        elseif lang == "lua" then
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
        end
    end
end

setup_servers()


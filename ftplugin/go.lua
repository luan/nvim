require('go').setup()

function GoImportsSync(timeout_ms)
    vim.lsp.buf.formatting_sync(nil, 1000)

    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, 't', true } }
    local params = vim.lsp.util.make_range_params()
    params.context = context

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result then return end
    for _, result in pairs(result) do
        if not result.result then return end
        result = result.result
        local edit = result[1].edit
        vim.lsp.util.apply_workspace_edit(edit)
    end
end

vim.cmd [[
augroup config#go
    autocmd!
    autocmd BufWritePre *.go lua GoImportsSync(1000)
augroup END
]]

-- vim.g.user_emmet_leader_key = '<leader>e'
-- vim.g.user_emmet_mode = 'nv'

vim.g.user_emmet_leader_key = "f"
vim.g.user_emmet_mode = "n"
vim.g.user_emmet_settings = {
    variables = { lang = "ja" },
    javascript = {
        extends = "jsx",
    },
    html = {
        default_attributes = {
            option = { value = vim.null },
            textarea = { id = vim.null, name = vim.null, cols = 10, rows = 10 },
        },
    },
}

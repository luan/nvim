local function config()
	require('nvim-autopairs').setup()
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp = require('cmp')
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

return {
	'windwp/nvim-autopairs',
	config = config,
}

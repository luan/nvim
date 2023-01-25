vim.keymap.set("n", "<F10>", [[<Cmd>TZMinimalist<CR>]])
vim.keymap.set("n", "<F11>", [[<Cmd>TZFocus<CR>]])
vim.keymap.set("n", "<F12>", [[<Cmd>TZAtaraxis<CR>]])

local function config()
	local true_zen = require("true-zen")
	true_zen.setup({
		ui = {
			bottom = {
				laststatus = 0,
				ruler = false,
				showmode = false,
				showcmd = false,
				cmdheight = 1,
			},
			top = {
				showtabline = 0,
			},
			left = {
				number = false,
				relativenumber = false,
				signcolumn = "no",
			},
		},
		modes = {
			ataraxis = {
				left_padding = 32,
				right_padding = 32,
				top_padding = 1,
				bottom_padding = 1,
				ideal_writing_area_width = 0,
				just_do_it_for_me = true,
				keep_default_fold_fillchars = true,
				custome_bg = "",
				bg_configuration = true,
				affected_higroups = { NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {},
					StatusLineNC = {}, SignColumn = {} }
			},
			focus = {
				margin_of_error = 5,
				focus_method = "experimental",
			},
		},
		integrations = {
			tmux = false,
			gitsigns = false,
			limelight = false,
			lualine = true,
		},
		misc = {
			on_off_commands = false,
			ui_elements_commands = false,
			cursor_by_mode = false,
		}
	})
end

return {
	'Pocco81/TrueZen.nvim',
	config = config,
}

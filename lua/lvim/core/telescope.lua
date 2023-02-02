return {
	themes = {
		center = {
			borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},

		cursor = require("telescope.themes").get_cursor {
			borderchars = { "█", "█", "▀", "█", "█", "█", "▀", "▀" },
		},

		dropdown = require("telescope.themes").get_dropdown {
			borderchars = { "█", "█", "▀", "█", "█", "█", "▀", "▀" },
			width = 0.9,
			prompt = " ",
			results_height = 25,
			previewer = false,
			winblend = 0,
		},
	},
}

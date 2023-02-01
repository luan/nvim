return {
	themes = {
		center = {
			borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
			layout_config = {
				sorting_strategy = "ascending",
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
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

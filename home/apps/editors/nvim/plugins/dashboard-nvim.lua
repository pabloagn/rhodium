require('dashboard').setup {
	theme = 'hyper',
	config = {
		header = {
			"╦═══╗┬   ┬┌───┐ ┌┬─┐┬┬   ┬┌─┬─┐",
			"║   ║│   ││   │  │ │││   ││ │ │",
			"╠═╦═╝├───┤│   │  │ │││   ││ │ │",
			"║ ║  │   ││   │  │ │││   ││ │ │",
			"╩ ╚══┴   ┴└───┘──┴─┘┴└───┘┴   ┴",
		},
		shortcut = {
			{ desc = '⊹ Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
			{ desc = '⊹ Rhodium', group = 'Number', action = 'edit ~/.config/nixos/flake.nix', key = 'r' },
		},
		packages = { enable = false }, -- This removes the plugin count
		project = { enable = true, limit = 8, icon = '', label = '', action = 'Telescope find_files cwd=' },
		mru = { enable = true, limit = 10, icon = '', label = '', cwd_only = false },
		footer = {
			"",
			"────────────── ◈ ──────────────",
			""
		},
	},
}

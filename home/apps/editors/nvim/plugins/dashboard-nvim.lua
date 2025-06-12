-- Force hide lualine on startup
vim.g.lualine_laststatus = vim.o.laststatus
if vim.fn.argc(-1) == 0 then
	vim.o.laststatus = 0
end

require('dashboard').setup {
	theme = 'hyper',
	hide = {
		statusline = true,
	},
	config = {
		header = { --HACK: We had to add some spaces due to logo imbalance
			"  ╦═══╗┬   ┬┌───┐ ┌┬─┐┬┬   ┬┌─┬─┐",
			"  ║   ║│   ││   │  │ │││   ││ │ │",
			"  ╠═╦═╝├───┤│   │  │ │││   ││ │ │",
			"  ║ ║  │   ││   │  │ │││   ││ │ │",
			"  ╩ ╚══┴   ┴└───┘──┴─┘┴└───┘┴   ┴",
			"",
			"",
		},
		shortcut = {
			{ desc = '⊹ Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
			{ desc = '⊹ Rhodium', group = 'Number', action = 'Telescope find_files cwd=~/dev/rhodium', key = 'r' },
			-- { desc = '⊹ Live Grep', group = 'Number', action = 'Telescope find_files cwd=~/dev/rhodium', key = 'g' },
			-- { desc = '⊹ Help', group = 'Number', action = 'Telescope find_files cwd=~/dev/rhodium', key = 'h' },
			{ desc = '⊹ Health', group = 'Number', action = 'checkhealth', key = 'h' },
		},

		packages = { enable = false }, -- Remove the plugin count
		project = { enable = true, limit = 8, icon = '', label = '', action = 'Telescope find_files cwd=' },
		mru = { enable = true, limit = 10, icon = '', label = '', cwd_only = false },
		footer = {
			"",
			"",
			"────────────── ‡ ──────────────",
			"",
			"",
		},
	},
}

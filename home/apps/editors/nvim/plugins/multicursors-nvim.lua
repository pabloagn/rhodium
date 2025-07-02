-- multicursors.lua
require("multicursors").setup({
	-- --- Core Settings ---
	DEBUG_MODE = false,
	create_commands = true,
	updatetime = 50,
	nowait = true,

	-- --- Mode Keys For Different Multicursor Modes ---
	mode_keys = {
		append = "a",
		change = "c",
		extend = "e",
		insert = "i",
	},

	-- --- Hint Window Configuration ---
	hint_config = {
		type = "window",
		position = "bottom-right",
		offset = 0,
		show_name = false,
		funcs = {},
		float_opts = {
			border = "single",
		},
	},

	-- --- Generate Hints Configuration ---
	generate_hints = {
		normal = true,
		insert = true,
		extend = true,
		config = {
			column_count = 1,
			max_hint_length = 25,
		},
	},

	-- Custom normal mode mappings
	normal_keys = {
		-- Clear other selections, keep main
		[","] = {
			method = function()
				local N = require("multicursors.normal_mode")
				N.clear_others()
			end,
			opts = { desc = "Clear others" },
		},

		-- Comment all selections
		["gc"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					local line_count = selection.end_row - selection.row + 1
					vim.cmd("normal " .. line_count .. "gcc")
				end)
			end,
			opts = { desc = "Comment selections" },
		},

		-- Additional multicursor operations
		["<C-n>"] = {
			method = function()
				require("multicursors.normal_mode").find_next()
			end,
			opts = { desc = "Find next" },
		},

		["<C-p>"] = {
			method = function()
				require("multicursors.normal_mode").find_prev()
			end,
			opts = { desc = "Find prev" },
		},

		["<C-x>"] = {
			method = function()
				require("multicursors.normal_mode").skip()
			end,
			opts = { desc = "Skip current" },
		},

		["<C-a>"] = {
			method = function()
				require("multicursors.normal_mode").find_all()
			end,
			opts = { desc = "Find all" },
		},

		-- Alignment operations
		["="] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal ==")
				end)
			end,
			opts = { desc = "Align selections" },
		},

		-- Indentation
		[">"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					local line_count = selection.end_row - selection.row + 1
					vim.cmd("normal " .. line_count .. ">>")
				end)
			end,
			opts = { desc = "Indent right" },
		},

		["<"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					local line_count = selection.end_row - selection.row + 1
					vim.cmd("normal " .. line_count .. "<<")
				end)
			end,
			opts = { desc = "Indent left" },
		},

		-- Case operations
		["~"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal ~")
				end)
			end,
			opts = { desc = "Toggle case" },
		},

		["gu"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal gul")
				end)
			end,
			opts = { desc = "Lowercase" },
		},

		["gU"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal gUl")
				end)
			end,
			opts = { desc = "Uppercase" },
		},
	},
})

-- Highlight customization for multicursor
vim.api.nvim_set_hl(0, "MultiCursor", {
	bg = "#22262D",
	fg = "#D3C6AA",
	reverse = false,
})

vim.api.nvim_set_hl(0, "MultiCursorMain", {
	bg = "#A7C080",
	fg = "#2D353B",
	bold = true,
	reverse = false,
})

vim.api.nvim_set_hl(0, "HydraRed", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "HydraBlue", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "HydraAmaranth", { fg = "#E67E80" })
vim.api.nvim_set_hl(0, "HydraTeal", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "HydraPink", { fg = "#7FBBB3" })

-- Override the hint window appearance
vim.api.nvim_set_hl(0, "HydraHint", {
	bg = "#090E13",
	fg = "#8891A5",
})

vim.api.nvim_set_hl(0, "HydraBorder", {
	fg = "#22262D",
	bg = "#090E13",
})

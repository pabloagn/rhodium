-- TODO: Test new setup
require("multicursors").setup({
	-- Core settings
	DEBUG_MODE = false,
	create_commands = true,
	updatetime = 50,
	nowait = true,

	-- Mode keys for different multicursor modes
	mode_keys = {
		append = "a",
		change = "c",
		extend = "e",
		insert = "i",
	},

	-- Hint window configuration - matching your which-key aesthetic
	hint_config = {
		float_opts = {
			border = "single",
			style = "minimal",
		},
		position = "bottom-right",
	},

	-- Generate hints for different modes
	generate_hints = {
		normal = true,
		insert = true,
		extend = true,
		config = {
			column_count = 1,
		},
	},

	-- Custom normal mode mappings with unicode symbols
	normal_keys = {
		-- Clear other selections, keep main
		[","] = {
			method = function()
				local N = require("multicursors.normal_mode")
				N.clear_others()
			end,
			opts = { desc = "⊗ Clear others" },
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
			opts = { desc = "⍝ Comment selections" },
		},

		-- Additional multicursor operations
		["<C-n>"] = {
			method = function()
				require("multicursors.normal_mode").find_next()
			end,
			opts = { desc = "⇢ Find next" },
		},

		["<C-p>"] = {
			method = function()
				require("multicursors.normal_mode").find_prev()
			end,
			opts = { desc = "⇠ Find prev" },
		},

		["<C-x>"] = {
			method = function()
				require("multicursors.normal_mode").skip()
			end,
			opts = { desc = "⤴ Skip current" },
		},

		["<C-a>"] = {
			method = function()
				require("multicursors.normal_mode").find_all()
			end,
			opts = { desc = "⊛ Find all" },
		},

		-- Alignment operations
		["="] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal ==")
				end)
			end,
			opts = { desc = "⊞ Align selections" },
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
			opts = { desc = "↦ Indent right" },
		},

		["<"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					local line_count = selection.end_row - selection.row + 1
					vim.cmd("normal " .. line_count .. "<<")
				end)
			end,
			opts = { desc = "↤ Indent left" },
		},

		-- Case operations
		["~"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal ~")
				end)
			end,
			opts = { desc = "⌘ Toggle case" },
		},

		["gu"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal gul")
				end)
			end,
			opts = { desc = "⇩ Lowercase" },
		},

		["gU"] = {
			method = function()
				require("multicursors.utils").call_on_selections(function(selection)
					vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
					vim.cmd("normal gUl")
				end)
			end,
			opts = { desc = "⇧ Uppercase" },
		},
	},
})

-- Highlight customization - matching your dark theme
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

-- Multicursor hint window styling to match which-key
vim.api.nvim_set_hl(0, "MultiCursorHint", {
	bg = "#0f1316",
	fg = "#D3C6AA",
})

vim.api.nvim_set_hl(0, "MultiCursorHintBorder", {
	fg = "#22262D",
	bg = "#0f1316",
})

-- Update your which-key multicursor group definition
require("which-key").add({
	{ "m", group = "⠿ Multicursor" },
	{ "ma", desc = "⊕ Add cursor" },
	{ "mc", desc = "⊗ Clear cursors" },
	{ "mf", desc = "⌆ Find word" },
	{ "ml", desc = "⊞ Line cursors" },
	{ "mn", desc = "⇢ Next match" },
	{ "mp", desc = "⇠ Prev match" },
	{ "ms", desc = "⤴ Skip match" },
	{ "mt", desc = "⌘ Toggle mode" },
	{ "mv", desc = "⊛ Visual select" },
})

-- require("multicursors").setup({
--   -- Core settings
--   DEBUG_MODE = false,
--   create_commands = true,
--   updatetime = 50,
--   nowait = true,
--
--   -- Mode keys for different multicursor modes
--   mode_keys = {
--     append = 'a',
--     change = 'c',
--     extend = 'e',
--     insert = 'i',
--   },
--
--   -- Hint window configuration
--   hint_config = {
--     float_opts = {
--       border = 'single',
--     },
--     position = 'bottom-right',
--   },
--
--   -- Generate hints for different modes
--   generate_hints = {
--     normal = true,
--     insert = true,
--     extend = true,
--     config = {
--       column_count = 1,
--     },
--   },
--
--   -- Custom normal mode mappings
--   normal_keys = {
--     -- Clear other selections, keep main
--     [','] = {
--       method = function()
--         local N = require("multicursors.normal_mode")
--         N.clear_others()
--       end,
--       opts = { desc = 'Clear others' },
--     },
--     -- Comment all selections
--     ['<C-/>'] = {
--       method = function()
--         require('multicursors.utils').call_on_selections(function(selection)
--           vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
--           local line_count = selection.end_row - selection.row + 1
--           vim.cmd('normal ' .. line_count .. 'gcc')
--         end)
--       end,
--       opts = { desc = 'Comment selections' },
--     },
--   },
-- })
--
-- -- Highlight customization
-- vim.api.nvim_set_hl(0, "MultiCursor", { reverse = true })
-- vim.api.nvim_set_hl(0, "MultiCursorMain", { reverse = true, bold = true })

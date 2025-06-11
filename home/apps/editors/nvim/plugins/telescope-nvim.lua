local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

telescope.setup({
	defaults = {
		-- Borders
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

		-- Prompt styling
		prompt_prefix = "λ ", -- Prefix at the prompt entry
		selection_caret = "● ", -- Prefix at the selected item
		entry_prefix = "○ ", -- Prefix at the non-selected item

		-- Visual settings
		winblend = 2, -- Add very subtle transparency
		color_devicons = true,
		path_display = { "truncate" },

		-- Layout
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.85,
			height = 0.80,
			preview_cutoff = 120,
			prompt_position = "top",
			horizontal = {
				preview_width = 0.6,
			},
			-- padding = {
			-- 	top = 2,
			-- 	bottom = 2,
			-- 	left = 2,
			-- 	right = 2,
			-- },
		},

		-- Sorting
		sorting_strategy = "ascending",

		-- File filtering
		file_ignore_patterns = {
			"%.git/",
			"node_modules/",
			"%.npm/",
			"__pycache__/",
			"%.pyc",
			"%.o",
			"%.a",
			"%.out",
			"%.class",
			"%.pdf",
			"%.mkv",
			"%.mp4",
			"%.zip"
		},

		-- Basic mappings
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			},
		},
	},

	-- Picker configurations
	pickers = {
		find_files = {
			hidden = true,
		},

		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
				},
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
	},
})

-- Only load extensions that are actually installed
pcall(telescope.load_extension, 'fzf')

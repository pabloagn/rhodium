local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")

-- Colors
local colors = {
	bg = "#0f1316",
	fg = "#DCE0E8",
	-- border = '#DCE0E8',
    border = "#22262d",
	selection_bg = "#1f272e",
}

-- Strategies
require("telescope.pickers.layout_strategies").horizontal_merged = function(
	picker,
	max_columns,
	max_lines,
	layout_config
)
	local layout =
		require("telescope.pickers.layout_strategies").horizontal(picker, max_columns, max_lines, layout_config)

	layout.prompt.title = ""
	layout.prompt.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

	layout.results.title = ""
	layout.results.borderchars = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
	layout.results.line = layout.results.line - 1
	layout.results.height = layout.results.height + 1

	-- Only modify preview if it exists (not disabled)
	if layout.preview then
		layout.preview.title = ""
		layout.preview.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
	end

	return layout
end

-- Apply colors
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg, fg = colors.fg })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.border, bg = colors.bg })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.border, bg = colors.bg })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.border, bg = colors.bg })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.border, bg = colors.bg })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = colors.fg, bg = colors.selection_bg })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = colors.border })

-- Setup
telescope.setup({
	defaults = {
		-- Visuals & layout
		winblend = 2,

		prompt_prefix = " λ ",
		selection_caret = " ● ",
		entry_prefix = " ○ ",

		-- The default layout will be the horizontal "matrix"
		layout_strategy = "horizontal_merged",
		layout_config = {
			-- Set the prompt to always be at the top of the window
			prompt_position = "top",
			width = 0.9,
			height = 0.85,
			horizontal = {
				preview_width = 0.6, -- Preview pane takes 60% of the width
			},
			-- Config for any pickers that use the vertical layout
			vertical = {
				mirror = true, -- Puts preview on top, results below
			},
		},

		sorting_strategy = "ascending",
		path_display = { "truncate" },
		color_devicons = false,

		file_ignore_patterns = {
			"%.git/",
			"node_modules/",
			"dist/",
			"build/",
			"coverage/",
			"target/",
			"__pycache__/",
			"%.pyc",
			"%.venv/",
			"venv/",
			"env/",
			"poetry.lock",
			"%.class",
			"%.jar",
			"%.o",
			"%.a",
			"%.so",
			"%.out",
			"%.exe",
			"%.cache/",
			"%.tmp/",
			"tmp/",
			"temp/",
			"%.DS_Store",
			"*.swp",
			"*.png",
			"*.jpg",
			"*.jpeg",
			"*.gif",
			"*.webp",
			"*.mp4",
			"*.mp3",
		},

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-o>"] = actions.select_tab,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<C-t>"] = trouble.open,
				["<Esc>"] = actions.close,
			},
			n = {
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-o>"] = actions.select_tab,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-t>"] = trouble.open,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			},
		},
	},

	-- Picker-Specific Overrides
	-- Normal Layouts
	pickers = {
		find_files = {},
		live_grep = {},
		grep_string = {},
		git_status = {},
		buffers = {
			previewer = true,
			-- layout_config = { width = 0.5, height = 0.8 },
			sort_lastused = true,
			mappings = {
				i = { ["<c-d>"] = actions.delete_buffer },
				n = { ["dd"] = actions.delete_buffer },
			},
		},
		help_tags = {},
		keymaps = {},
		commands = {},
		diagnostics = {},
	},

	-- Extensions
	extensions = {
		frecency = {
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = { "*.git/*", "*/tmp/*" },
			disable_devicons = false,
		},
		todo_comments = {},
		live_grep_args = {},
	},
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "frecency")
pcall(telescope.load_extension, "live_grep_args")
pcall(telescope.load_extension, "todo-comments")

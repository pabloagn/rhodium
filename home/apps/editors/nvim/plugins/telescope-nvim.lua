local telescope = require('telescope')
local actions = require('telescope.actions')
-- local action_layout = require('telescope.actions.layout')

telescope.setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- Window borders
		prompt_prefix = "λ ", -- Prefix at the prompt entry
		selection_caret = "● ", -- Prefix at the selected item
		entry_prefix = "○ ", -- Prefix at the non-selected item
		winblend = 2, -- Very subtle transparency
		color_devicons = true, -- Enable devicons
		path_display = { "truncate" },
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.85,
			height = 0.80,
			preview_cutoff = 120,
			prompt_position = "top",
			horizontal = {
				preview_width = 0.6,
			},
		},
		sorting_strategy = "ascending",

		-- Global ignores
		file_ignore_patterns = {
			-- Version control
			"%.git/",
			"%.svn/",
			"%.hg/",

			-- Node.js / JavaScript
			"node_modules/",
			"%.npm/",
			"%.yarn/",
			"%.pnpm%-store/",
			"dist/",
			"build/",
			"coverage/",
			"%.next/",
			"%.nuxt/",

			-- Python
			"__pycache__/",
			"%.pyc",
			"%.pyo",
			"%.pyd",
			"%.venv/",
			"venv/",
			"env/",
			"%.tox/",
			"%.pytest_cache/",
			"%.mypy_cache/",
			"%.coverage",
			"htmlcov/",
			"%.egg%-info/",
			"dist/",
			"build/",

			-- Poetry
			"%.poetry/",
			"poetry%.lock",

			-- Rust
			"target/",
			"Cargo%.lock",

			-- Java
			"%.class",
			"%.jar",
			"%.war",
			"%.ear",
			"target/",
			"%.gradle/",
			"build/",

			-- C/C++
			"%.o",
			"%.a",
			"%.so",
			"%.dylib",
			"%.dll",
			"%.out",
			"%.exe",

			-- Cache and temporary directories
			"%.cache/",
			"%.tmp/",
			"tmp/",
			"temp/",
			"%.direnv/",
			"%.DS_Store",
			"Thumbs%.db",

			-- Backup files
			"%.bkp",
			"%.backup",
			"%.bak",
			"%.swp",
			"%.swo",
			"*~",

			-- Image formats
			"%.png",
			"%.jpg",
			"%.jpeg",
			"%.gif",
			"%.bmp",
			"%.tiff",
			"%.ico",
			"%.webp",

			-- Video formats
			"%.mkv",
			"%.mp4",
			"%.avi",
			"%.mov",
			"%.wmv",
			"%.flv",
			"%.webm",

			-- Audio formats
			"%.mp3",
			"%.wav",
			"%.flac",
			"%.aac",
			"%.ogg",

			-- Archive formats
			-- "%.zip",
			-- "%.tar",
			-- "%.gz",
			-- "%.rar",
			-- "%.7z",
			-- "%.xz",
			-- "%.bz2",

			-- Documents
			-- "%.pdf",
			"%.doc",
			"%.docx",
			"%.xls",
			"%.xlsx",
			"%.ppt",
			"%.pptx",

			-- IDE and editor files
			-- "%.vscode/",
			"%.idea/",
			"%.eclipse/",
			"%.settings/",

			-- OS specific
			"%.Trash/",
			"%.recycle/",

			-- Log files
			"%.log",
			"logs/",
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

	extensions = {
		frecency = {
			-- HACK: Remove the annoying rebuild message on each prompt
			validate = false,
			auto_validate = false,
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = { "*.git/*", "*/tmp/*" },
			disable_devicons = false,
		},
		todo_comments = {
			-- TODO: Add any todo-comments telescope specific config here
		}
	},
})

-- Load existing extensions
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'todo_comments') 

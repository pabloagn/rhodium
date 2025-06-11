require("todo-comments").setup({
	signs = true, -- Show icons in the signs column
	sign_priority = 8,

	keywords = {
		FIX = {
			icon = "✗", -- Icon used for the sign, and in search results
			color = "error", -- Can be a hex color, or a named color
			alt = { "SEV1", "SEV2", "SEV3" }, -- Severities
		},
		TODO = {
			icon = "●",
			color = "info",
		},
		DONE = {
			icon = "✓",
			color = "done"
		},
		NOTE = {
			icon = "■",
			color = "hint",
		},
		HACK = {
			icon = "ℹ",
			color = "warning"
		},
		WARN = {
			icon = "!",
			color = "warning",
		},
		PERF = {
			icon = "◍",
			alt = { "IMPR" }
		},
		TEST = {
			icon = "◌",
			color = "test",
			alt = { "TESTING", "PASSED", "FAILED" }
		},
	},

	gui_style = {
		fg = "NONE", -- The gui style to use for the fg highlight group
		bg = "BOLD", -- The gui style to use for the bg highlight group
	},

	merge_keywords = true, -- When true, custom keywords will be merged with the defaults

	-- Highlighting
	highlight = {
		multiline = true,          -- Enable multine todo comments
		multiline_pattern = "^.",  -- Lua pattern to match the next multiline
		multiline_context = 10,    -- Extra lines that will be re-evaluated when changing a line
		before = "",               -- "fg" or "bg" or empty
		keyword = "wide",          -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
		after = "fg",              -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern used for highlighting (vim regex)
		comments_only = true,      -- Uses treesitter to match keywords in comments only
		max_line_len = 400,        -- Ignore lines longer than this
		exclude = {},              -- List of file types to exclude highlighting
	},

	-- Colors
	colors = {
		error = { "DiagnosticError", "ErrorMsg" },
		warning = { "DiagnosticWarn", "WarningMsg" },
		info = { "DiagnosticInfo" },
		hint = { "DiagnosticHint" },
		default = { "Identifier" },
		test = { "Identifier" },
		done = { "healthSuccess" }
	},

	-- Search configuration for ripgrep
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS):]], -- Ripgrep regex
	},
})


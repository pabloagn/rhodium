require("flash").setup({
	-- Labels configuration - using home row keys for efficiency
	labels = "asdfghjklqwertyuiopzxcvbnm",
	search = {
		-- Enable multi-window jumping for maximum reach
		multi_window = true,
		-- Standard forward search behavior
		forward = true,
		-- Enable wrap around for continuous navigation
		wrap = true,
		-- Use exact mode by default for precision
		mode = "exact",
		-- Disable incremental to avoid visual noise
		incremental = false,
		-- Exclude non-focusable windows and UI elements
		exclude = {
			"notify",
			"cmp_menu",
			"noice",
			"flash_prompt",
			"NvimTree",
			"neo-tree",
			"trouble",
			"aerial",
			"qf",
			"help",
			"man",
			"lspinfo",
			"spectre_panel",
			"lir",
			"DressingSelect",
			"tsplayground",
			function(win)
				-- Exclude non-focusable windows
				return not vim.api.nvim_win_get_config(win).focusable
			end,
		},
		-- No trigger character for immediate response
		trigger = "",
		-- No max length limit
		max_length = false,
	},
	jump = {
		-- Save jumps in jumplist for <C-o>/<C-i> navigation
		jumplist = true,
		-- Jump to start of match by default
		pos = "start",
		-- Don't pollute search history
		history = false,
		-- Don't affect search register
		register = false,
		-- Don't clear hlsearch after jump
		nohlsearch = false,
		-- Don't auto-jump on single match (explicit control)
		autojump = false,
		-- Let flash decide inclusive/exclusive based on mode
		inclusive = nil,
		-- No offset
		offset = nil,
	},
	label = {
		-- Enable uppercase labels for more options
		uppercase = true,
		-- Exclude confusing characters
		exclude = "",
		-- Show label for first match (can use <CR> to jump)
		current = true,
		-- Show labels after match for better visibility
		after = true,
		-- Don't show labels before (cleaner look)
		before = false,
		-- Overlay style for minimal visual disruption
		style = "overlay",
		-- Reuse lowercase labels when typing more chars
		reuse = "lowercase",
		-- Prioritize closer targets
		distance = true,
		-- No minimum pattern length for labels
		min_pattern_length = 0,
		-- Rainbow disabled for professional look
		rainbow = {
			enabled = false,
			shade = 5,
		},
		-- Default format function
		format = function(opts)
			return { { opts.match.label, opts.hl_group } }
		end,
	},
	highlight = {
		-- Show backdrop for better visibility
		backdrop = true,
		-- Highlight search matches
		matches = true,
		-- High priority to override other highlights
		priority = 5000,
		groups = {
			match = "FlashMatch",
			current = "FlashCurrent",
			backdrop = "FlashBackdrop",
			label = "FlashLabel",
		},
	},
	-- Use default action (jumping)
	action = nil,
	-- No initial pattern
	pattern = "",
	-- Don't continue last search by default
	continue = false,
	-- No dynamic config
	config = nil,
	-- Mode-specific configurations
	modes = {
		-- Search mode (/ and ?)
		search = {
			-- Enable flash during search for power users
			enabled = true,
			highlight = { backdrop = false },
			jump = { history = true, register = true, nohlsearch = true },
			search = {
				-- These get set automatically based on search direction
				-- forward = true/false
				-- mode = "search"
				-- incremental = true when 'incsearch' is enabled
			},
		},
		-- Character motions (f, F, t, T)
		char = {
			enabled = true,
			-- Dynamic config for operator-pending mode
			config = function(opts)
				-- Auto-hide in operator-pending yanks
				opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

				-- Enable jump labels only when appropriate
				opts.jump_labels = opts.jump_labels
					and vim.v.count == 0
					and vim.fn.reg_executing() == ""
					and vim.fn.reg_recording() == ""
			end,
			-- Hide after jump when not using labels
			autohide = false,
			-- Enable jump labels for f/F/t/T
			jump_labels = true,
			-- Enable multi-line for f/F/t/T
			multi_line = true,
			-- Don't use these keys as labels after motion
			label = { exclude = "hjkliardc" },
			-- Enable all character motions
			keys = { "f", "F", "t", "T", ";", "," },
			-- Character repeat behavior
			char_actions = function(motion)
				return {
					[";"] = "next",
					[","] = "prev",
					-- Clever-f style: same key repeats
					[motion:lower()] = "next",
					[motion:upper()] = "prev",
				}
			end,
			search = { wrap = false },
			highlight = { backdrop = true },
			jump = {
				register = false,
				-- Don't autojump on single match for explicit control
				autojump = false,
			},
		},
		-- Treesitter mode
		treesitter = {
			labels = "abcdefghijklmnopqrstuvwxyz",
			jump = { pos = "range", autojump = true },
			search = { incremental = false },
			label = { before = true, after = true, style = "inline" },
			highlight = {
				backdrop = false,
				matches = false,
			},
		},
		-- Treesitter search mode
		treesitter_search = {
			jump = { pos = "range" },
			search = { multi_window = true, wrap = true, incremental = false },
			remote_op = { restore = true },
			label = { before = true, after = true, style = "inline" },
		},
		-- Remote mode
		remote = {
			remote_op = { restore = true, motion = true },
		},
	},
	-- Prompt configuration
	prompt = {
		enabled = true,
		prefix = { { "⚡", "FlashPromptIcon" } },
		win_config = {
			relative = "editor",
			width = 1,
			height = 1,
			row = -1,
			col = 0,
			zindex = 1000,
		},
	},
	-- Remote operator configuration
	remote_op = {
		-- Don't restore by default
		restore = false,
		-- Use window cursor for current, new motion for remote
		motion = false,
	},
})

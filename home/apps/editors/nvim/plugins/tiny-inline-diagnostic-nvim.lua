require("tiny-inline-diagnostic").setup({
	-- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont"
	preset = "modern",

	-- Appearance settings
	transparent_bg = false,
	transparent_cursorline = false,

	-- Multilines settings
	multilines = {
		enabled = false,
		always_show = false,
	},

	-- Severity filter - which levels to show
	severity = {
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.INFO,
		vim.diagnostic.severity.HINT,
	},

	-- Override specific options if needed
	options = {
		-- Show diagnostic source
		show_source = true,
		-- Throttle updates
		throttle = 20,
		-- Custom format function
		format = function(diagnostic)
			return diagnostic.message
		end,
	},

	-- Disable on specific filetypes
	disabled_ft = { "lazy", "mason", "help" },
})

-- Disable native virtual text when using tiny-inline-diagnostic
vim.diagnostic.config({ virtual_text = false })

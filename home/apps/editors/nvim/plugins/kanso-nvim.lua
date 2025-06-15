require("kanso").setup({
	bold = true, -- enable bold fonts
	italics = true, -- enable italics
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = {},
	typeStyle = {},
	transparent = true, -- match your current tokyonight setup
	dimInactive = false, -- dim inactive window
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = { zen = {}, pearl = {}, ink = {}, mist = {}, all = {} },
	},
	overrides = function(colors) -- add/modify highlights
		return {}
	end,
	theme = "zen", -- Load "zen" theme (dark)
	background = { -- map the value of 'background' option to a theme
		dark = "zen", -- you can try "ink" or "mist"
		light = "pearl", -- light theme option
	},
})

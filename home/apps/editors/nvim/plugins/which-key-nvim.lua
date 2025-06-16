require("which-key").setup({
	preset = "helix",
	delay = 200,

	-- Window
	win = {
		border = "single",
		padding = { 1, 2 }, -- Extra padding: top bottom, right left
		wo = {
			winblend = 5,
		},
	},

	-- Layout
	layout = {
		width = { min = 20 },
		spacing = 3,
	},

	-- Custom key symbols
	icons = {
		breadcrumb = "›",
		separator = "→",
		group = "",
		ellipsis = "…",
		mappings = false,
		rules = false,
		colors = false,
		keys = {
			Up = "↑",
			Down = "↓",
			Left = "←",
			Right = "→",
			C = "⌃",
			M = "⌥",
			D = "⌘",
			S = "⇧",
			CR = "⏎",
			Esc = "⎋",
			Space = "␣",
			Tab = "⇥",
			BS = "⌫",
			NL = "⏎",
			ScrollWheelUp = "↑",
			ScrollWheelDown = "↓",
			F1 = "ƒ1",
			F2 = "ƒ2",
			F3 = "ƒ3",
			F4 = "ƒ4",
			F5 = "ƒ5",
			F6 = "ƒ6",
			F7 = "ƒ7",
			F8 = "ƒ8",
			F9 = "ƒ9",
			F10 = "ƒ10",
			F11 = "ƒ11",
			F12 = "ƒ12",
		},
	},
})

-- Group Definitions
require("which-key").add({
	-- Core groups
	{ "<leader>a", group = "§ Outline" },
	{ "<leader>b", group = "⎕ Buffer" },
	{ "<leader>c", group = "⍝ Comment" },
	{ "<leader>d", group = "‼ Diagnostic" },
	{ "<leader>e", group = "∆ Edit" },
	{ "<leader>f", group = "⌆ Find" },
	{ "<leader>g", group = "⠮ Git" },
	{ "<leader>i", group = "↦ Indent" },
	{ "<leader>l", group = "ψ LSP" },
	{ "<leader>m", group = "⠿ Multicursor" },
	{ "<leader>r", group = "⍋ Replace" },
	{ "<leader>s", group = "⌽ Cycle" },
	{ "<leader>t", group = "† Trouble" },
	{ "<leader>z", group = "± Fold" },

	-- Buffer subgroups
	{ "<leader>bc", group = "⊗ Close" },
	{ "<leader>bg", group = "⊙ Group" },
	{ "<leader>bm", group = "⊚ Move" },
	{ "<leader>bs", group = "⊛ Sort" },

	-- Non-leader groups for navigation
	{ "]", group = "⇢ Next" },
	{ "[", group = "⇠ Prev" },
	{ "g", group = "⟐ Go" },
})

vim.api.nvim_set_hl(0, "WhichKeyNormal", {
	bg = "#0f1316",
})

vim.api.nvim_set_hl(0, "WhichKeyBorder", {
	bg = "#22262D",
})


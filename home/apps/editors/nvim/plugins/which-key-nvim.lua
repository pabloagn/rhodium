require("which-key").setup({
	-- Window settings
	preset = "classic",
	delay = 200,

	-- Appearance settings
	win = {
		border = "none",
		padding = { 1, 2 },
		wo = {
			winblend = 10,
		},
	},

	-- Layout configuration
	layout = {
		width = { min = 20 },
		spacing = 3,
	},

	-- Disable built-in icons - we'll use custom symbols
	icons = {
		breadcrumb = "◦",
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
			ScrollWheelDown = "↓",
			ScrollWheelUp = "↑",
			NL = "⏎",
			BS = "⌫",
			Space = "␣",
			Tab = "⇥",
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

-- Group definitions with sacred computer symbols
require("which-key").add({
	-- Core groups
	{ "<leader>b", group = "◈ Buffer" },
	{ "<leader>c", group = "◇ Comment" },
	{ "<leader>d", group = "◆ Diagnostic" },
	{ "<leader>e", group = "◉ Edit" },
	{ "<leader>f", group = "◎ Find" },
	{ "<leader>g", group = "◐ Git" },
	{ "<leader>i", group = "◑ Indent" },
	{ "<leader>l", group = "◒ LSP" },
	{ "<leader>m", group = "◓ Multicursor" },
	{ "<leader>s", group = "◔ Switch" },
	{ "<leader>t", group = "◕ Trouble" },

	-- Buffer subgroups
	{ "<leader>bc", group = "⊗ Close" },
	{ "<leader>bg", group = "⊙ Group" },
	{ "<leader>bm", group = "⊚ Move" },
	{ "<leader>bs", group = "⊛ Sort" },

	-- Comment annotations
	{ "<leader>c", group = "◇ Comment", mode = { "n", "v" } },

	-- Diagnostic filtering
	{ "<leader>d", group = "◆ Diagnostic" },

	-- Find categories
	{ "<leader>f", group = "◎ Find" },

	-- Git operations
	{ "<leader>g", group = "◐ Git" },

	-- LSP actions
	{ "<leader>l", group = "◒ LSP" },

	-- Multicursor operations
	{ "<leader>m", group = "◓ Multicursor" },

	-- Trouble categories
	{ "<leader>t", group = "◕ Trouble" },

	-- Special symbols for navigation
	{ "]", group = "⇢ Next" },
	{ "[", group = "⇠ Prev" },
	{ "g", group = "⟐ Go" },
})

-- Additional descriptions for specific keys
require("which-key").add({
	-- Buffer operations
	{ "<leader>b1", desc = "① Buffer 1" },
	{ "<leader>b2", desc = "② Buffer 2" },
	{ "<leader>b3", desc = "③ Buffer 3" },
	{ "<leader>b4", desc = "④ Buffer 4" },
	{ "<leader>b5", desc = "⑤ Buffer 5" },
	{ "<leader>b6", desc = "⑥ Buffer 6" },
	{ "<leader>b7", desc = "⑦ Buffer 7" },
	{ "<leader>b8", desc = "⑧ Buffer 8" },
	{ "<leader>b9", desc = "⑨ Buffer 9" },

	-- Diagnostic severity levels
	{ "<leader>d1", desc = "⚠ Errors Only" },
	{ "<leader>d2", desc = "⚡ Errors + Warnings" },
	{ "<leader>d3", desc = "⦿ All Diagnostics" },

	-- Special function keys
	{ "<leader><space>", desc = "⌧ Clear Search" },
	{ "<leader>n", desc = "⌗ Toggle Numbers" },
	{ "<leader>y", desc = "⧉ Copy All" },
	{ "<leader>D", desc = "⌦ Delete All" },
	{ "<leader>w", desc = "⌘ Save & Close" },
	{ "<leader>q", desc = "⌫ Force Close" },

	-- Navigation symbols
	{ "]d", desc = "⇢ Next Diagnostic" },
	{ "[d", desc = "⇠ Prev Diagnostic" },
	{ "]e", desc = "⇢ Next Error" },
	{ "[e", desc = "⇠ Prev Error" },
	{ "]t", desc = "⇢ Next TODO" },
	{ "[t", desc = "⇠ Prev TODO" },
	{ "]T", desc = "⇢ Next Task" },
	{ "[T", desc = "⇠ Prev Trouble" },

	-- Go-to operations
	{ "gd", desc = "⟐ Definition" },
	{ "gr", desc = "⟐ References" },
	{ "gi", desc = "⟐ Implementation" },
	{ "gt", desc = "⟐ Type Definition" },
})

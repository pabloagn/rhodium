require("which-key").setup({
	preset = "helix",
	delay = 200,
	-- Window
	win = {
		border = "single",
		padding = { 1, 2 },
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
	{ "<leader>x", group = "✕ Noice" },
	{ "<leader>z", group = "± Fold" },

	-- Buffer subgroups
	{ "<leader>bc", group = "⊗ Close" },
	{ "<leader>bg", group = "⊙ Group" },
	{ "<leader>bm", group = "⊚ Move" },
	{ "<leader>bs", group = "⊛ Sort" },

	-- Noice subgroup
	{ "<leader>xn", group = "◊ Noice" },

	-- Non-leader groups for navigation
	{ "]", group = "⇢ Next" },
	{ "[", group = "⇠ Prev" },
	{ "g", group = "⟐ Go" },
	{ "g[", group = "⇤ First" },
	{ "g]", group = "⇥ Last" },

	-- FtPlugin
	{ ";", group = "◈ FileType" },
})

-- Individual keybind descriptions
require("which-key").add({
	-- General
	{ "<leader><space>", desc = "⊘ Clear search highlight" },
	{ "<leader>n", desc = "№ Toggle line numbers" },
	{ "<leader>y", desc = "⊕ Copy entire buffer" },
	{ "<leader>D", desc = "⊖ Delete entire buffer" },

	-- Outline/Aerial
	{ "<leader>aa", desc = "◫ Toggle sidebar" },
	{ "<leader>aA", desc = "◬ Toggle navigation" },
	{ "<leader>af", desc = "◪ Focus sidebar" },
	{ "{", desc = "∧ Next symbol" },
	{ "}", desc = "∨ Previous symbol" },

	-- Comment
	{ "<leader>cc", desc = "≈ Toggle line/count" },
	{ "<leader>ca", desc = "⊡ Append comment" },
	{ "<leader>cA", desc = "≡ Comment all lines" },
	{ "<leader>ct", desc = "✓ Insert TODO" },
	{ "<leader>cf", desc = "✗ Insert FIX" },
	{ "<leader>cn", desc = "※ Insert NOTE" },
	-- TODO: Change this
	{ "<leader>ch", desc = "⚡ Insert HACK" },
	{ "<leader>cw", desc = "⚠ Insert WARN" },
	{ "<leader>cp", desc = "⊕ Insert PERF" },
	{ "<leader>ce", desc = "⊝ Insert TEST" },
	{ "<leader>cd", desc = "☑ Toggle TODO/DONE" },
	{ "<leader>cl", desc = "≣ List buffer TODOs" },

	-- Edit
	{ "<leader>er", desc = "⊹ Replace buffer with clipboard" },

	-- Replace (Spectre)
	{ "<leader>rt", desc = "◎ Toggle Spectre" },
	{ "<leader>rw", desc = "◉ Search current word" },
	{ "<leader>rf", desc = "◐ Search in current file" },

	-- LSP Actions
	{ "<leader>lh", desc = "◈ Show hover" },
	{ "<leader>lf", desc = "⌘ Format (Conform)" },
	{ "<leader>lr", desc = "⊛ Rename symbol" },
	{ "<leader>la", desc = "⌥ Code actions" },

	-- LSP Navigation
	{ "gd", desc = "◆ Go to definition" },
	{ "gr", desc = "◇ Go to references" },
	{ "gi", desc = "◊ Go to implementation" },
	{ "gt", desc = "○ Go to type definition" },

	-- Find/Search
	{ "<leader>ff", desc = "⊡ Files" },
	{ "<leader>fp", desc = "◉ Project files" },
	{ "<leader>fb", desc = "⊞ Buffers" },
	{ "<leader>fr", desc = "↺ Recent (Frecency)" },
	{ "<leader>fg", desc = "⊙ Live grep with args" },
	{ "<leader>fw", desc = "⊛ Word under cursor" },
	{ "<leader>fd", desc = "⊖ Diagnostics (current)" },
	{ "<leader>fD", desc = "⊗ Diagnostics (all)" },
	{ "<leader>fs", desc = "◈ Symbols (document)" },
	{ "<leader>fS", desc = "◉ Symbols (workspace)" },
	{ "<leader>fh", desc = "◊ Help" },
	{ "<leader>fk", desc = "⌨ Keymaps" },
	{ "<leader>fo", desc = "⊙ Options" },
	{ "<leader>fc", desc = "⌘ Command history" },
	{ "<leader>fH", desc = "⍉ Search history" },
	{ "<leader>ft", desc = "✓ TODOs with priority" },

	-- Trouble
	{ "<leader>tt", desc = "◈ Toggle diagnostics" },
	{ "<leader>tb", desc = "◉ Buffer diagnostics" },
	{ "<leader>tq", desc = "◊ Quickfix list" },
	{ "<leader>tl", desc = "○ Location list" },
	{ "<leader>tr", desc = "◇ LSP references" },
	{ "<leader>td", desc = "◆ LSP definitions" },
	{ "<leader>ti", desc = "◊ LSP implementations" },
	{ "<leader>ts", desc = "⊛ Document symbols" },
	{ "<leader>tc", desc = "⊗ Close all" },

	-- Trouble Navigation
	{ "]T", desc = "▷ Next trouble item" },
	{ "[T", desc = "◁ Previous trouble item" },
	{ "g]T", desc = "⇥ Last trouble item" },
	{ "g[T", desc = "⇤ First trouble item" },

	-- Diagnostics
	{ "<leader>dv", desc = "◫ Toggle virtual text" },
	{ "<leader>dl", desc = "≡ Show line diagnostics" },
	{ "<leader>db", desc = "≣ Show buffer diagnostics" },
	{ "]d", desc = "▸ Next diagnostic" },
	{ "[d", desc = "◂ Previous diagnostic" },
	{ "]e", desc = "▹ Next error" },
	{ "[e", desc = "◃ Previous error" },

	-- Indents
	{ "<leader>ii", desc = "→ Smart indent" },
	{ "<leader>io", desc = "← Smart outdent" },

	-- Treesitter
	{ "<leader>z", desc = "± Toggle treesitter folding" },

	-- Buffers
	{ "<leader>s", desc = "▶ Next buffer" },
	{ "<leader>S", desc = "◀ Previous buffer" },
	{ "<leader>w", desc = "✓ Save and close" },
	{ "<leader>q", desc = "✗ Close without saving" },
	{ "<leader>bmn", desc = "▷ Move next" },
	{ "<leader>bmp", desc = "◁ Move prev" },
	{ "<leader>b1", desc = "① Go to buffer 1" },
	{ "<leader>b2", desc = "② Go to buffer 2" },
	{ "<leader>b3", desc = "③ Go to buffer 3" },
	{ "<leader>b4", desc = "④ Go to buffer 4" },
	{ "<leader>b5", desc = "⑤ Go to buffer 5" },
	{ "<leader>b6", desc = "⑥ Go to buffer 6" },
	{ "<leader>b7", desc = "⑦ Go to buffer 7" },
	{ "<leader>b8", desc = "⑧ Go to buffer 8" },
	{ "<leader>b9", desc = "⑨ Go to buffer 9" },
	{ "<leader>bcp", desc = "◎ Pick to close" },
	{ "<leader>bco", desc = "◉ Close others" },
	{ "<leader>bcr", desc = "▶ Close to right" },
	{ "<leader>bcl", desc = "◀ Close to left" },
	{ "<leader>bp", desc = "⊙ Pick buffer" },
	{ "<leader>bP", desc = "⊡ Toggle pin" },
	{ "<leader>bsd", desc = "◫ Sort by directory" },
	{ "<leader>bse", desc = "◬ Sort by extension" },
	{ "<leader>bst", desc = "◪ Sort by tabs" },
	{ "<leader>bgt", desc = "⊞ Toggle Tests group" },
	{ "<leader>bgd", desc = "⊟ Toggle Docs group" },

	-- Git
	{ "<leader>gc", desc = "◎ Commits" },
	{ "<leader>gb", desc = "⌥ Branches" },
	{ "<leader>gs", desc = "≡ Status" },

	-- TODOs Navigation
	{ "]t", desc = "▸ Next todo comment" },
	{ "[t", desc = "◂ Previous todo comment" },
	{ "]T", desc = "▹ Next task" },

	-- Multicursor
	{ "<leader>m", desc = "⊙ Start on word/selection" },

	-- Noice
	{ "<S-Enter>", desc = "⤴ Redirect cmdline", mode = "c" },
	{ "<leader>xnl", desc = "◊ Last message" },
	{ "<leader>xnh", desc = "⌚ History" },
	{ "<leader>xna", desc = "≡ All messages" },
	{ "<leader>xnd", desc = "⊗ Dismiss all" },
	{ "<leader>xnt", desc = "⊙ Picker" },
	{ "<c-f>", desc = "↓ Scroll forward", mode = { "i", "n", "s" } },
	{ "<c-b>", desc = "↑ Scroll backward", mode = { "i", "n", "s" } },
})

-- Highlight settings
vim.api.nvim_set_hl(0, "WhichKeyNormal", {
	-- bg = "#0f1316",
	bg = "#090E13",
})
vim.api.nvim_set_hl(0, "WhichKeyBorder", {
	fg = "#22262D",
	-- bg = "#0f1316",
	bg = "#090E13",
})
vim.api.nvim_set_hl(0, "WhichKeyTitle", {
	-- bg = "#0f1316",
	bg = "#090E13",
})

-- Add filetype-specific group names
local FILETYPE_ICON = "☠"

-- Add filetype-specific group names
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"sh",
		"c",
		"clojure",
		"commonlisp",
		"lisp",
		"css",
		"csv",
		"cuda",
		"dart",
		"dockerfile",
		"elixir",
		"elisp",
		"elm",
		"erlang",
		"fortran",
		"gleam",
		"go",
		"graphql",
		"haskell",
		"hcl",
		"html",
		"http",
		"hyprlang",
		"ini",
		"java",
		"javascript",
		"js",
		"json",
		"julia",
		"kdl",
		"kotlin",
		"latex",
		"tex",
		"lua",
		"luadoc",
		"make",
		"makefile",
		"markdown",
		"md",
		"nix",
		"nu",
		"ocaml",
		"odin",
		"perl",
		"php",
		"python",
		"py",
		"r",
		"rasi",
		"regex",
		"ruby",
		"rb",
		"rust",
		"rs",
		"scss",
		"solidity",
		"sql",
		"ssh_config",
		"svelte",
		"swift",
		"sxhkdrc",
		"terraform",
		"tf",
		"tmux",
		"toml",
		"tsv",
		"tsx",
		"typescript",
		"ts",
		"typst",
		"vim",
		"vimdoc",
		"vue",
		"xml",
		"yaml",
		"yml",
		"yuck",
		"zathurarc",
		"zig",
		"fennel",
	},
	callback = function(ev)
		local ft_names = {
			-- Shell
			bash = FILETYPE_ICON .. " Bash",
			sh = FILETYPE_ICON .. " Shell",

			-- Systems
			c = FILETYPE_ICON .. " C",
			cuda = FILETYPE_ICON .. " CUDA",
			fortran = FILETYPE_ICON .. " Fortran",
			zig = FILETYPE_ICON .. " Zig",
			rust = FILETYPE_ICON .. " Rust",
			rs = FILETYPE_ICON .. " Rust",

			-- Lisps
			clojure = FILETYPE_ICON .. " Clojure",
			commonlisp = FILETYPE_ICON .. " Common Lisp",
			lisp = FILETYPE_ICON .. " Lisp",
			elisp = FILETYPE_ICON .. " Emacs Lisp",
			fennel = FILETYPE_ICON .. " Fennel",

			-- Web
			css = FILETYPE_ICON .. " CSS",
			scss = FILETYPE_ICON .. " SCSS",
			html = FILETYPE_ICON .. " HTML",
			javascript = FILETYPE_ICON .. " JavaScript",
			js = FILETYPE_ICON .. " JavaScript",
			typescript = FILETYPE_ICON .. " TypeScript",
			ts = FILETYPE_ICON .. " TypeScript",
			tsx = FILETYPE_ICON .. " TSX",
			vue = FILETYPE_ICON .. " Vue",
			svelte = FILETYPE_ICON .. " Svelte",

			-- Data
			json = FILETYPE_ICON .. " JSON",
			yaml = FILETYPE_ICON .. " YAML",
			yml = FILETYPE_ICON .. " YAML",
			toml = FILETYPE_ICON .. " TOML",
			xml = FILETYPE_ICON .. " XML",
			csv = FILETYPE_ICON .. " CSV",
			tsv = FILETYPE_ICON .. " TSV",
			kdl = FILETYPE_ICON .. " KDL",
			ini = FILETYPE_ICON .. " INI",

			-- Languages
			python = FILETYPE_ICON .. " Python",
			py = FILETYPE_ICON .. " Python",
			lua = FILETYPE_ICON .. " Lua",
			luadoc = FILETYPE_ICON .. " LuaDoc",
			java = FILETYPE_ICON .. " Java",
			kotlin = FILETYPE_ICON .. " Kotlin",
			go = FILETYPE_ICON .. " Go",
			dart = FILETYPE_ICON .. " Dart",
			swift = FILETYPE_ICON .. " Swift",
			ruby = FILETYPE_ICON .. " Ruby",
			rb = FILETYPE_ICON .. " Ruby",
			perl = FILETYPE_ICON .. " Perl",
			php = FILETYPE_ICON .. " PHP",
			r = FILETYPE_ICON .. " R",
			julia = FILETYPE_ICON .. " Julia",
			haskell = FILETYPE_ICON .. " Haskell",
			elm = FILETYPE_ICON .. " Elm",
			elixir = FILETYPE_ICON .. " Elixir",
			erlang = FILETYPE_ICON .. " Erlang",
			gleam = FILETYPE_ICON .. " Gleam",
			ocaml = FILETYPE_ICON .. " OCaml",
			odin = FILETYPE_ICON .. " Odin",
			solidity = FILETYPE_ICON .. " Solidity",

			-- Markup & Docs
			markdown = FILETYPE_ICON .. " Markdown",
			md = FILETYPE_ICON .. " Markdown",
			latex = FILETYPE_ICON .. " LaTeX",
			tex = FILETYPE_ICON .. " LaTeX",
			typst = FILETYPE_ICON .. " Typst",

			-- Config & Build
			dockerfile = FILETYPE_ICON .. " Dockerfile",
			make = FILETYPE_ICON .. " Makefile",
			makefile = FILETYPE_ICON .. " Makefile",
			nix = FILETYPE_ICON .. " Nix",
			terraform = FILETYPE_ICON .. " Terraform",
			tf = FILETYPE_ICON .. " Terraform",
			hcl = FILETYPE_ICON .. " HCL",

			-- Vim
			vim = FILETYPE_ICON .. " Vim",
			vimdoc = FILETYPE_ICON .. " VimDoc",

			-- Tools & Misc
			sql = FILETYPE_ICON .. " SQL",
			graphql = FILETYPE_ICON .. " GraphQL",
			http = FILETYPE_ICON .. " HTTP",
			regex = FILETYPE_ICON .. " Regex",
			tmux = FILETYPE_ICON .. " Tmux",
			ssh_config = FILETYPE_ICON .. " SSH Config",

			-- WM & System
			hyprlang = FILETYPE_ICON .. " Hyprlang",
			sxhkdrc = FILETYPE_ICON .. " SXHKD",
			rasi = FILETYPE_ICON .. " Rasi",
			yuck = FILETYPE_ICON .. " Yuck",
			zathurarc = FILETYPE_ICON .. " Zathura",

			-- Shell alternatives
			nu = FILETYPE_ICON .. " Nushell",
		}

		local ft = vim.bo[ev.buf].filetype
		if ft_names[ft] then
			require("which-key").add({
				{ ";", group = ft_names[ft], buffer = ev.buf },
			})
		end
	end,
})

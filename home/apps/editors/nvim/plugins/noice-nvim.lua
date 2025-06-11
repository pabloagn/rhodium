-- Clear lazy messages
if vim.o.filetype == "lazy" then
	vim.cmd([[messages clear]])
end

require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		opts = {},
		format = {
			cmdline = { pattern = "^:", icon = "λ", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = "∩", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = "∪", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "⊂", lang = "bash" },
			lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
		},
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = {
			enabled = true,
			auto_open = {
				enabled = false,
			},
		}
	},
	routes = {
		-- Hide file info messages
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			view = "mini",
		},
		-- Hide deprecation warnings
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "deprecated" },
					{ find = "deprecation" },
					{ find = "Deprecated" },
				},
			},
			opts = { skip = true },
		},
		-- Hide plugin update notifications
		{
			filter = {
				event = "notify",
				any = {
					{ find = "No information available" },
					{ find = "Plugin" },
					{ find = "lazy.nvim" },
				},
			},
			opts = { skip = true },
		},
		-- Hide LSP progress notifications
		{
			filter = {
				event = "lsp",
				kind = "progress",
			},
			opts = { skip = true },
		},
		-- Hide "written" and similar file messages
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "written" },
					{ find = "W" }, -- [w] when writing
					{ find = "%d+ changes" },
					{ find = "%d+ change" },
					{ find = "Before #%d+" },
					{ find = "After #%d+" },
					{ find = "%d+L, %d+C written" },
				},
			},
			opts = { skip = true },
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = false,
	},
	views = {
		cmdline_popup = {
			border = {
				style = "single",
				padding = { 0, 1 },
			},
			filter_options = {},
			win_options = {
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 8,
				col = "50%",
			},
			size = {
				width = 60,
				height = 10,
			},
			border = {
				style = "single",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	},
})

-- Key mappings
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Noice keymaps
map("c", "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
map("n", "<leader>snl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
map("n", "<leader>snh", function() require("noice").cmd("history") end, { desc = "Noice History" })
map("n", "<leader>sna", function() require("noice").cmd("all") end, { desc = "Noice All" })
map("n", "<leader>snd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
map("n", "<leader>snt", function() require("noice").cmd("pick") end, { desc = "Noice Picker (Telescope/FzfLua)" })

-- Scroll mappings for LSP documentation
map({ "i", "n", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true, desc = "Scroll Forward" })

map({ "i", "n", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true, desc = "Scroll Backward" })

-- -- Clear lazy messages
-- if vim.o.filetype == "lazy" then
-- 	vim.cmd([[messages clear]])
-- end
--
-- require("noice").setup({
-- 	cmdline = {
-- 		enabled = true,
-- 		view = "cmdline_popup",
-- 		opts = {},
-- 		format = {
-- 			cmdline = { pattern = "^:", icon = "λ", lang = "vim" },
-- 			search_down = { kind = "search", pattern = "^/", icon = "∩", lang = "regex" },
-- 			search_up = { kind = "search", pattern = "^%?", icon = "∪", lang = "regex" },
-- 			filter = { pattern = "^:%s*!", icon = "⊂", lang = "bash" },
-- 			lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
-- 			help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
-- 		},
-- 	},
-- 	lsp = {
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true,
-- 		},
-- 		signature = {
-- 			enabled = false,
-- 			auto_open = {
-- 				enabled = false,
-- 			},
-- 		}
-- 	},
-- 	routes = {
-- 		-- Hide file info messages
-- 		{
-- 			filter = {
-- 				event = "msg_show",
-- 				any = {
-- 					{ find = "%d+L, %d+B" },
-- 					{ find = "; after #%d+" },
-- 					{ find = "; before #%d+" },
-- 				},
-- 			},
-- 			view = "mini",
-- 		},
-- 		-- Hide deprecation warnings
-- 		{
-- 			filter = {
-- 				event = "msg_show",
-- 				any = {
-- 					{ find = "deprecated" },
-- 					{ find = "deprecation" },
-- 					{ find = "Deprecated" },
-- 				},
-- 			},
-- 			opts = { skip = true },
-- 		},
-- 		-- Hide plugin update notifications
-- 		{
-- 			filter = {
-- 				event = "notify",
-- 				any = {
-- 					{ find = "No information available" },
-- 					{ find = "Plugin" },
-- 					{ find = "lazy.nvim" },
-- 				},
-- 			},
-- 			opts = { skip = true },
-- 		},
-- 		-- Hide LSP progress notifications
-- 		{
-- 			filter = {
-- 				event = "lsp",
-- 				kind = "progress",
-- 			},
-- 			opts = { skip = true },
-- 		},
-- 		-- Hide "written" and similar file messages
-- 		{
-- 			filter = {
-- 				event = "msg_show",
-- 				any = {
-- 					{ find = "written" },
-- 					{ find = "W" }, -- [w] when writing
-- 					{ find = "%d+ changes" },
-- 					{ find = "%d+ change" },
-- 					{ find = "Before #%d+" },
-- 					{ find = "After #%d+" },
-- 					{ find = "%d+L, %d+C written" },
-- 				},
-- 			},
-- 			opts = { skip = true },
-- 		},
-- 	},
-- 	presets = {
-- 		bottom_search = true,
-- 		command_palette = true,
-- 		long_message_to_split = true,
-- 		lsp_doc_border = false,
-- 	},
-- 	views = {
-- 		cmdline_popup = {
-- 			border = {
-- 				style = "single",
-- 				padding = { 0, 1 },
-- 			},
-- 			filter_options = {},
-- 			win_options = {
-- 				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
-- 			},
-- 		},
-- 		popupmenu = {
-- 			relative = "editor",
-- 			position = {
-- 				row = 8,
-- 				col = "50%",
-- 			},
-- 			size = {
-- 				width = 60,
-- 				height = 10,
-- 			},
-- 			border = {
-- 				style = "single",
-- 				padding = { 0, 1 },
-- 			},
-- 			win_options = {
-- 				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
-- 			},
-- 		},
-- 	},
-- })
--
-- -- Key mappings
-- local function map(mode, lhs, rhs, opts)
-- 	opts = opts or {}
-- 	vim.keymap.set(mode, lhs, rhs, opts)
-- end
--
-- -- Noice keymaps
-- map("c", "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
-- map("n", "<leader>snl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
-- map("n", "<leader>snh", function() require("noice").cmd("history") end, { desc = "Noice History" })
-- map("n", "<leader>sna", function() require("noice").cmd("all") end, { desc = "Noice All" })
-- map("n", "<leader>snd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
-- map("n", "<leader>snt", function() require("noice").cmd("pick") end, { desc = "Noice Picker (Telescope/FzfLua)" })
--
-- -- Scroll mappings for LSP documentation
-- map({ "i", "n", "s" }, "<c-f>", function()
-- 	if not require("noice.lsp").scroll(4) then
-- 		return "<c-f>"
-- 	end
-- end, { silent = true, expr = true, desc = "Scroll Forward" })
--
-- map({ "i", "n", "s" }, "<c-b>", function()
-- 	if not require("noice.lsp").scroll(-4) then
-- 		return "<c-b>"
-- 	end
-- end, { silent = true, expr = true, desc = "Scroll Backward" })

-- TODO: Test
-- TODO: Two
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
		-- Add custom popup view for messages
		popup = {
			backend = "popup",
			relative = "editor",
			close = {
				events = { "BufLeave" },
				keys = { "q", "<Esc>" },
			},
			enter = false,
			border = {
				style = "single",
			},
			position = {
				row = 2,
				col = "50%",
			},
			size = {
				width = "auto",
				height = "auto",
				max_height = 20,
				max_width = 60,
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
		-- Mini view for less important messages
		mini = {
			backend = "mini",
			timeout = 2000,
			reverse = true,
			position = {
				row = -2,
				col = "100%",
				-- col = 0,
			},
			size = {
				height = 1,
				width = "auto",
				max_width = 60,
			},
			border = {
				style = "none",
			},
			win_options = {
				winblend = 30,
				winhighlight = {
					Normal = "NoiceMini",
					IncSearch = "",
					CurSearch = "",
					Search = "",
				},
			},
		},
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = {
			enabled = false, -- Disable signature help
		},
		hover = {
			enabled = false, -- Disable hover messages
		},
		message = {
			enabled = false, -- Disable LSP messages
		},
	},
	-- Route ALL messages to appear as popup dialogs instead of cmdline
	routes = {
		-- Route ALL msg_show events to popup
		{
			filter = {
				event = "msg_show",
			},
			view = "popup",
		},
		-- Route file info messages to mini popup
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
					{ find = "written" },
					{ find = "%d+ changes" },
					{ find = "%d+ change" },
					{ find = "undid" },
					{ find = "redid" },
					{ find = "%d+ fewer lines" },
					{ find = "%d+ more lines" },
					{ find = "%d+ lines yanked" },
					{ find = "%d+ lines deleted" },
				},
			},
			view = "mini",
		},
		-- Route notifications to popup
		{
			filter = {
				event = "notify",
			},
			view = "popup",
		},
		-- Route LSP messages to popup
		{
			filter = {
				event = "lsp",
				kind = "message",
			},
			view = "popup",
		},
	},
	-- Enable message handling
	messages = {
		enabled = true, -- Enable message history
	},
	-- Enable notifications
	notify = {
		enabled = true,
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = false, -- Don't split long messages
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

-- Keep vim settings minimal - let noice handle the routing
vim.opt.shortmess:append("I") -- Don't show intro message
vim.opt.showmode = false -- Don't show mode since lualine shows it

-- Key mappings (keeping your existing ones)
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

require("noice").setup({
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			opts = {},
			format = {
				cmdline = { pattern = "^:", icon = "▶", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = "↓", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = "↑", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "⌘", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "λ", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "⁇" },
				input = { view = "cmdline_input", icon = "✎" },
			},
		},
		routes = {
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
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},
		views = {
			notify = {
				backend = "notify",
				replace = true,
				merge = true,
			},
			mini = {
				backend = "mini",
				border = {
					style = "single",
				},
				position = {
					row = -2,
					col = "100%",
				},
				win_options = {
					winblend = 0,
				},
			},
			cmdline_popup = {
				border = {
					style = "single",
				},
				win_options = {
					winblend = 0,
				},
			},
			popupmenu = {
				border = {
					style = "single",
				},
				win_options = {
					winblend = 0,
				},
			},
		},
	},
	config = function(_, opts)
		-- HACK: Noice shows messages from before it was enabled,
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)

		local bg_color = "#1a1b26" -- Adjust this to match your theme
		local text_color = "#c0caf5" -- Adjust this to match your theme

		vim.api.nvim_set_hl(0, "NoicePopup", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoiceMini", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoiceConfirm", { bg = bg_color, fg = text_color })

		-- For the mini view (the notification that appears)
		vim.api.nvim_set_hl(0, "NoiceFormatProgressDone", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoiceFormatProgressTodo", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { bg = bg_color, fg = text_color })

		-- Override floating window highlights to ensure solid background
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color, fg = text_color })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg_color, fg = bg_color }) -- Hide border by matching bg
	end,
})

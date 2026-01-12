require("bufferline").setup({
	options = {
		mode = "buffers",
		themable = true,
		numbers = "none",
		-- Smart close commands
		close_command = function(bufnum)
			-- Store current buffer to restore focus if needed
			local current = vim.api.nvim_get_current_buf()

			-- Switch to the buffer we're closing if it's not current
			if bufnum ~= current then
				vim.api.nvim_set_current_buf(bufnum)
			end

			-- Use our smart close function
			require("functions").smart_close_buffer()
		end,
		right_mouse_command = function(bufnum)
			local current = vim.api.nvim_get_current_buf()
			if bufnum ~= current then
				vim.api.nvim_set_current_buf(bufnum)
			end
			require("functions").smart_close_buffer()
		end,
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		-- Visual settings
		indicator = {
			icon = "│",
			style = "icon",
		},
		buffer_close_icon = "×",
		modified_icon = "●",
		close_icon = "×",
		left_trunc_marker = "◂",
		right_trunc_marker = "▸",
		-- Layout
		max_name_length = 30,
		max_prefix_length = 15,
		truncate_names = true,
		tab_size = 21,
		-- Diagnostics integration
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		-- Color and styling
		color_icons = false,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		persist_buffer_sort = true,
		-- Separator styling (sharp, squared borders for sacred aesthetic)
		separator_style = { "│", "│" },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		-- Sorting
		sort_by = "insert_after_current",
		-- Hover functionality
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		-- Custom filter to hide certain buffers
		custom_filter = function(buf_number, buf_numbers)
			-- Filter out certain filetypes
			local filetype = vim.bo[buf_number].filetype
			if filetype == "qf" or filetype == "fugitive" or filetype == "git" then
				return false
			end
			-- Filter out by buffer name
			local name = vim.fn.bufname(buf_number)
			if name:match("NvimTree") or name:match("COMMIT_EDITMSG") then
				return false
			end
			return true
		end,
		-- Offset for other plugins (like nvim-tree)
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
			{
				filetype = "neo-tree",
				text = "Neo Tree",
				text_align = "center",
				separator = true,
			},
		},
	},
	highlights = {
		-- Sacred Computer Aesthetic: Active tab (white bg, black text)
		buffer_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
			bold = true,
			italic = false,
		},
		indicator_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
		},
		close_button_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
		},
		modified_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
		},
		separator_selected = {
			fg = "#5c6066",
			bg = "#DCE0E8",
		},
		numbers_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
		},
		diagnostic_selected = {
			fg = "#0f1316",
			bg = "#DCE0E8",
		},
		-- Sacred Computer Aesthetic: Inactive tabs (minimal, symmetrical)
		buffer_visible = {
			fg = "#7a8187",
			bg = "#1a1e24",
		},
		close_button_visible = {
			fg = "#5c6066",
			bg = "#1a1e24",
		},
		modified_visible = {
			fg = "#c4b28a",
			bg = "#1a1e24",
		},
		separator_visible = {
			fg = "#5c6066",
			bg = "#1a1e24",
		},
		-- Sacred Computer Aesthetic: Background/inactive buffers
		buffer = {
			fg = "#5c6066",
			bg = "#0f1316",
		},
		close_button = {
			fg = "#393B44",
			bg = "#0f1316",
		},
		modified = {
			fg = "#c4b28a",
			bg = "#0f1316",
		},
		separator = {
			fg = "#5c6066",
			bg = "#0f1316",
		},
		-- Fill and background
		fill = {
			bg = "#0f1316",
		},
		tab_separator = {
			fg = "#5c6066",
		},
	},
})

require('bufferline').setup {
	options = {
		mode = "buffers", -- Show buffers, not tabs
		-- style_preset = bufferline.style_preset.no_italic,
		themable = true,
		numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,

		-- Visual settings
		indicator = {
			icon = '▎',
			style = 'icon',
		},
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',

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
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		persist_buffer_sort = true,

		-- Separator styling
		separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
		enforce_regular_tabs = false,
		always_show_bufferline = true,

		-- Sorting
		sort_by = 'insert_after_current',

		-- Groups (optional)
		groups = {
			options = {
				toggle_hidden_on_enter = true
			},
			items = {
				{
					name = "Tests",
					highlight = { underline = true, sp = "blue" },
					priority = 2,
					icon = "",
					matcher = function(buf)
						return buf.name:match('%_test') or buf.name:match('%_spec')
					end,
				},
				{
					name = "Docs",
					highlight = { underline = true, sp = "green" },
					priority = 3,
					icon = "",
					matcher = function(buf)
						return buf.name:match('%.md') or buf.name:match('%.txt')
					end,
				}
			}
		},

		-- Hover functionality
		hover = {
			enabled = true,
			delay = 200,
			reveal = { 'close' }
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
				separator = true
			},
			{
				filetype = "neo-tree",
				text = "Neo Tree",
				text_align = "center",
				separator = true
			}
		}
	},

	highlights = {
		-- Customize colors to match your theme
		buffer_selected = {
			bold = true,
			italic = false,
		},
		indicator_selected = {
			fg = '#80a0ff',
			bg = '#1a1b26',
		},
		close_button_selected = {
			fg = '#ff5555',
		},
		modified_selected = {
			fg = '#ffb86c',
		}
	}
}

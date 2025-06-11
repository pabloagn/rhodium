require('bufferline').setup {
	options = {
		mode = "buffers", -- Show buffers, not tabs
		style_preset = bufferline.style_preset.no_italic,
		themable = true,
		numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,

		-- Visual settings
		indicator = {
			icon = '▎', -- This is the indicator icon
			style = 'icon', -- 'icon' | 'underline' | 'none'
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
		separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
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

-- Key mappings for buffer navigation
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Navigate buffers
map('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
map('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
map('n', '<leader>bl', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
map('n', '<leader>bh', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })

-- Move buffers
map('n', '<leader>bmn', ':BufferLineMoveNext<CR>', { desc = 'Move buffer next', silent = true })
map('n', '<leader>bmp', ':BufferLineMovePrev<CR>', { desc = 'Move buffer prev', silent = true })

-- Go to buffer by number
map('n', '<leader>b1', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Go to buffer 1', silent = true })
map('n', '<leader>b2', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Go to buffer 2', silent = true })
map('n', '<leader>b3', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Go to buffer 3', silent = true })
map('n', '<leader>b4', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Go to buffer 4', silent = true })
map('n', '<leader>b5', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Go to buffer 5', silent = true })
map('n', '<leader>b6', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Go to buffer 6', silent = true })
map('n', '<leader>b7', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Go to buffer 7', silent = true })
map('n', '<leader>b8', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Go to buffer 8', silent = true })
map('n', '<leader>b9', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Go to buffer 9', silent = true })

-- Close buffers
map('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Pick buffer to close', silent = true })
map('n', '<leader>bC', ':BufferLineCloseOthers<CR>', { desc = 'Close other buffers', silent = true })
map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer', silent = true })
map('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete buffer', silent = true })

-- Close buffers in direction
map('n', '<leader>bcr', ':BufferLineCloseRight<CR>', { desc = 'Close buffers to right', silent = true })
map('n', '<leader>bcl', ':BufferLineCloseLeft<CR>', { desc = 'Close buffers to left', silent = true })

-- Pick buffer
map('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer', silent = true })

-- Pin/unpin buffer
map('n', '<leader>bP', ':BufferLineTogglePin<CR>', { desc = 'Toggle pin buffer', silent = true })

-- Sort buffers
map('n', '<leader>bsd', ':BufferLineSortByDirectory<CR>', { desc = 'Sort by directory', silent = true })
map('n', '<leader>bse', ':BufferLineSortByExtension<CR>', { desc = 'Sort by extension', silent = true })
map('n', '<leader>bst', ':BufferLineSortByTabs<CR>', { desc = 'Sort by tabs', silent = true })

-- Buffer groups
map('n', '<leader>bgt', ':BufferLineGroupToggle Tests<CR>', { desc = 'Toggle test group', silent = true })
map('n', '<leader>bgd', ':BufferLineGroupToggle Docs<CR>', { desc = 'Toggle docs group', silent = true })

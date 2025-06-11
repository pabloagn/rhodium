require("trouble").setup({
	auto_close = false,    -- auto close when there are no items
	auto_open = false,     -- auto open when there are items
	auto_preview = true,   -- automatically open preview when on an item
	auto_refresh = true,   -- auto refresh when open
	auto_jump = false,     -- auto jump to the item when there's only one
	focus = false,         -- Focus the window when opened
	restore = true,        -- restores the last location in the list when opening
	follow = true,         -- Follow the current item
	indent_guides = true,  -- show indent guides
	max_items = 200,       -- limit number of items that can be displayed per section
	multiline = true,      -- render multi-line messages
	pinned = false,        -- When pinned, the opened trouble window will be bound to the current buffer
	warn_no_results = true, -- show a warning when there are no results
	open_no_results = false, -- open the trouble window when there are no results

	-- Window configuration
	win = {
		type = "split",                   -- split, vsplit, float
		relative = "editor",              -- editor, win, cursor
		position = "bottom",              -- bottom, top, left, right
		size = { height = 0.3, width = 0.5 }, -- size of the window
		zindex = 200,                     -- zindex of the window
		wo = {
			wrap = false,
			nu = true,
			rnu = true,
			cursorbind = false,
			cursorline = true,
			cursorcolumn = false,
			colorcolumn = "",
			signcolumn = "yes",
			statuscolumn = "",
			winbar = "",
		},
	},

	-- Preview window configuration
	preview = {
		type = "split",
		relative = "win",
		position = "right",
		size = { width = 0.4, height = 0.4 },
		zindex = 100,
		wo = {
			wrap = true,
			nu = false,
			rnu = false,
			cursorbind = true,
			cursorline = true,
			cursorcolumn = false,
			signcolumn = "no",
			colorcolumn = "",
			winbar = "",
		},
	},

	-- Throttle refresh rate
	throttle = {
		refresh = 20,                        -- fetches new data when needed
		update = 10,                         -- updates the window
		render = 10,                         -- renders the window
		follow = 100,                        -- follows the current item
		preview = { ms = 100, debounce = true }, -- preview delay
	},

	-- Custom modes
	modes = {
		-- Built-in modes
		lsp_references = {
			win = { position = "right" },
		},
		lsp_definitions = {
			win = { position = "right" },
		},
		lsp_declarations = {
			win = { position = "right" },
		},
		lsp_type_definitions = {
			win = { position = "right" },
		},
		lsp_implementations = {
			win = { position = "right" },
		},
		lsp_incoming_calls = {
			win = { position = "right" },
		},
		lsp_outgoing_calls = {
			win = { position = "right" },
		},

		-- Custom diagnostics modes
		buffer_diagnostics = {
			mode = "diagnostics",
			filter = { buf = 0 },
			win = { position = "bottom" },
		},

		project_diagnostics = {
			mode = "diagnostics",
			filter = {},
			win = { position = "bottom" },
		},

		-- Custom symbols mode
		symbols = {
			desc = "document symbols",
			mode = "lsp_document_symbols",
			focus = false,
			win = { position = "right", size = { width = 0.3 } },
			filter = {
				-- remove Package since luals uses it for control flow structures
				["not"] = { ft = "lua", kind = "Package" },
				any = {
					-- all symbol kinds for help files
					ft = "help",
					-- default set of symbol kinds
					kind = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Namespace",
						"Package",
						"Property",
						"Struct",
						"Trait",
					},
				},
			},
		},
	},

	-- Icons configuration
	icons = {
		indent = {
			top = "│ ",
			middle = "├╴",
			last = "└╴",
			fold_open = " ",
			fold_closed = " ",
			ws = "  ",
		},
		folder_closed = " ",
		folder_open = " ",
		kinds = {
			Array = " ",
			Boolean = "󰨙 ",
			Class = " ",
			Constant = "󰏿 ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Function = "󰊕 ",
			Interface = " ",
			Key = " ",
			Method = "󰊕 ",
			Module = " ",
			Namespace = "󰦮 ",
			Null = " ",
			Number = "󰎠 ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			String = " ",
			Struct = "󰆼 ",
			TypeParameter = " ",
			Variable = "󰀫 ",
		},
	},

	-- Formatters for different item types
	formatters = {
		-- Default diagnostic formatter
		diagnostic = {
			"{severity_icon}{item.source} {item.message:Normal}",
			"{item.pos.filename:Title}:{item.pos.lnum:LineNr}:{item.pos.col:Number} ",
		},
		-- LSP reference formatter
		lsp_reference = {
			"{item.text:Normal}",
			"{item.pos.filename:Title}:{item.pos.lnum:LineNr}:{item.pos.col:Number} ",
		},
		-- Symbol formatter
		lsp_symbol = {
			"{kind_icon} {item.name:Normal} {item.kind:Comment}",
			"{item.pos.filename:Title}:{item.pos.lnum:LineNr}:{item.pos.col:Number} ",
		},
	},

	-- Custom filters
	filters = {
		-- Custom filter for current buffer only
		current_buf = function(item)
			return item.buf == vim.api.nvim_get_current_buf()
		end,
		-- Filter for errors only
		errors_only = function(item)
			return item.severity == vim.diagnostic.severity.ERROR
		end,
		-- Filter for warnings and errors
		warnings_and_errors = function(item)
			return item.severity <= vim.diagnostic.severity.WARN
		end,
	},

	-- Custom sorters
	sorters = {
		-- Sort by severity, then by line number
		severity_line = function(items)
			table.sort(items, function(a, b)
				if a.severity ~= b.severity then
					return a.severity < b.severity
				end
				return a.pos.lnum < b.pos.lnum
			end)
			return items
		end,
	},
})

-- Key mappings for Trouble
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Primary diagnostic toggles
map("n", "<leader>xx", function() require("trouble").toggle("diagnostics") end, { desc = "Toggle Diagnostics (Trouble)" })
map("n", "<leader>xX", function() require("trouble").toggle("diagnostics", { filter = { buf = 0 } }) end,
	{ desc = "Toggle Buffer Diagnostics (Trouble)" })

-- LSP references and definitions
map("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end,
	{ desc = "Toggle LSP References (Trouble)" })
map("n", "<leader>xd", function() require("trouble").toggle("lsp_definitions") end,
	{ desc = "Toggle LSP Definitions (Trouble)" })
map("n", "<leader>xi", function() require("trouble").toggle("lsp_implementations") end,
	{ desc = "Toggle LSP Implementations (Trouble)" })
map("n", "<leader>xt", function() require("trouble").toggle("lsp_type_definitions") end,
	{ desc = "Toggle LSP Type Definitions (Trouble)" })

-- Document symbols
map("n", "<leader>xs", function() require("trouble").toggle("symbols") end, { desc = "Toggle Symbols (Trouble)" })

-- Quickfix and location lists
map("n", "<leader>xq", function() require("trouble").toggle("qflist") end, { desc = "Toggle Quickfix (Trouble)" })
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Toggle Location List (Trouble)" })

-- Navigation within trouble
map("n", "]x", function() require("trouble").next({ skip_groups = true, jump = true }) end,
	{ desc = "Next Trouble Item" })
map("n", "[x", function() require("trouble").prev({ skip_groups = true, jump = true }) end,
	{ desc = "Previous Trouble Item" })

-- Advanced navigation
map("n", "]X", function() require("trouble").last({ skip_groups = true, jump = true }) end,
	{ desc = "Last Trouble Item" })
map("n", "[X", function() require("trouble").first({ skip_groups = true, jump = true }) end,
	{ desc = "First Trouble Item" })

-- Close all trouble windows
map("n", "<leader>xc", function() require("trouble").close() end, { desc = "Close Trouble" })

-- Custom modes
map("n", "<leader>xp", function() require("trouble").toggle("project_diagnostics") end,
	{ desc = "Project Diagnostics (Trouble)" })
map("n", "<leader>xb", function() require("trouble").toggle("buffer_diagnostics") end,
	{ desc = "Buffer Diagnostics (Trouble)" })

-- Telescope integration
local telescope_trouble = require("trouble.sources.telescope")
map("n", "<leader>ft", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map_telescope)
			map_telescope("i", "<c-t>", telescope_trouble.open)
			map_telescope("n", "<c-t>", telescope_trouble.open)
			return true
		end,
	})
end, { desc = "Find Files with Trouble integration" })

-- Statusline integration (for lualine)
--[[
Add this to your lualine config:
{
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })
    table.insert(opts.sections.lualine_c, {
      symbols.get,
      cond = symbols.has,
    })
  end,
}
--]]

-- Auto commands for enhanced behavior
local trouble_group = vim.api.nvim_create_augroup("TroubleConfig", { clear = true })

-- Auto open trouble when there are diagnostics
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = trouble_group,
	callback = function()
		local diagnostics = vim.diagnostic.get(0)
		if #diagnostics > 0 and not require("trouble").is_open() then
			-- Uncomment to auto-open on diagnostics
			-- require("trouble").open("diagnostics")
		end
	end,
})

-- Close trouble when no diagnostics
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = trouble_group,
	callback = function()
		local diagnostics = vim.diagnostic.get(0)
		if #diagnostics == 0 and require("trouble").is_open("diagnostics") then
			-- Uncomment to auto-close when no diagnostics
			-- require("trouble").close("diagnostics")
		end
	end,
})

-- Highlight configuration
vim.api.nvim_create_autocmd("ColorScheme", {
	group = trouble_group,
	callback = function()
		-- Custom highlight groups for trouble
		vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NormalNC" })
		vim.api.nvim_set_hl(0, "TroubleText", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TroubleDirectory", { link = "Directory" })
		vim.api.nvim_set_hl(0, "TroubleSource", { link = "Comment" })
		vim.api.nvim_set_hl(0, "TroubleCode", { link = "Comment" })
		vim.api.nvim_set_hl(0, "TroubleCount", { link = "TabLineSel" })
		vim.api.nvim_set_hl(0, "TroublePreview", { link = "Search" })
	end,
})

-- Load the highlight configuration immediately
vim.cmd("doautocmd ColorScheme")

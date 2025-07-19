local functions = require("functions")
local builtin = require("telescope.builtin")

-- --- Leaders ---
-- ---------------------------------------------------------------------------
vim.g.mapleader = " " -- Leader
vim.g.maplocalleader = " " -- Local leader

-- --- General ---
-- ---------------------------------------------------------------------------
-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })
-- Yank all buffer
vim.keymap.set("n", "<Leader>Y", ":%y+<CR>", { noremap = true, silent = true, desc = "Yank entire buffer to clip" })
-- Delete all buffer
vim.keymap.set("n", "<Leader>D", ":%d+<CR>", { noremap = true, silent = true, desc = "Delete entire buffer" })
-- Comment all lines
vim.keymap.set("n", "<Leader>C", function()
	local line_count = vim.api.nvim_buf_line_count(0)
	require("Comment.api").toggle.linewise.count(line_count)
end, { desc = "Comment all lines" })

-- --- Toggle (space) ---
-- ---------------------------------------------------------------------------
local visual_line_mode = false

local function toggle_visual_line_movement()
	visual_line_mode = not visual_line_mode

	local filetypes = { "markdown", "text", "rst", "tex", "typst", "org" }
	local current_ft = vim.bo.filetype

	if vim.tbl_contains(filetypes, current_ft) then
		if visual_line_mode then
			vim.keymap.set({ "n", "v", "o", "x" }, "<Down>", "gj", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "<Up>", "gk", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "g<Down>", "j", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "g<Up>", "k", { buffer = true, noremap = true, silent = true })
			print("Visual line movement enabled for " .. current_ft)
		else
			vim.keymap.del({ "n", "v", "o", "x" }, "<Down>", { buffer = true })
			vim.keymap.del({ "n", "v", "o", "x" }, "<Up>", { buffer = true })
			vim.keymap.del({ "n", "v", "o", "x" }, "g<Down>", { buffer = true })
			vim.keymap.del({ "n", "v", "o", "x" }, "g<Up>", { buffer = true })
			print("Visual line movement disabled for " .. current_ft)
		end
	else
		print("Visual line movement only works for prose files (markdown, text, rst, tex, typst, org)")
	end
end

-- Toggle visual line movement
vim.keymap.set("n", "<leader><space>v", toggle_visual_line_movement, {
	noremap = true,
	silent = true,
	desc = "Toggle visual line movement",
})

-- Toggle line number
vim.keymap.set(
	{ "n", "v", "o", "x" },
	"<leader><space>n",
	"<cmd>set nu! rnu!<CR>",
	{ noremap = true, silent = true, desc = "Toggle line numbers" }
)

-- Toggle zen mode
vim.keymap.set("n", "<leader><space>z", function()
	require("zen-mode").toggle()
end, {
	noremap = true,
	silent = true,
	desc = "Toggle zen mode",
})

-- Apply to prose files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "rst", "tex", "typst", "org" },
	callback = function()
		if visual_line_mode then
			vim.keymap.set({ "n", "v", "o", "x" }, "<Down>", "gj", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "<Up>", "gk", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "g<Down>", "j", { buffer = true, noremap = true, silent = true })
			vim.keymap.set({ "n", "v", "o", "x" }, "g<Up>", "k", { buffer = true, noremap = true, silent = true })
		end
	end,
})

-- --- Harpoon ---
-- ---------------------------------------------------------------------------
-- File marking and navigation
vim.keymap.set("n", "<leader>ha", function()
	require("harpoon"):list():add()
end, {
	noremap = true,
	silent = true,
	desc = "Add file to Harpoon",
})

vim.keymap.set("n", "<leader>hh", function()
	local harpoon = require("harpoon")
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, {
	noremap = true,
	silent = true,
	desc = "Toggle Harpoon menu",
})

-- Direct navigation to marks
vim.keymap.set("n", "<leader>h1", function()
	require("harpoon"):list():select(1)
end, {
	noremap = true,
	silent = true,
	desc = "Harpoon to file 1",
})

vim.keymap.set("n", "<leader>h2", function()
	require("harpoon"):list():select(2)
end, {
	noremap = true,
	silent = true,
	desc = "Harpoon to file 2",
})

vim.keymap.set("n", "<leader>h3", function()
	require("harpoon"):list():select(3)
end, {
	noremap = true,
	silent = true,
	desc = "Harpoon to file 3",
})

vim.keymap.set("n", "<leader>h4", function()
	require("harpoon"):list():select(4)
end, {
	noremap = true,
	silent = true,
	desc = "Harpoon to file 4",
})

-- Quick navigation without leader (similar to buffer navigation)
vim.keymap.set("n", "<M-h>", function()
	require("harpoon"):list():select(1)
end, {
	noremap = true,
	silent = true,
	desc = "Quick Harpoon 1",
})

vim.keymap.set("n", "<M-j>", function()
	require("harpoon"):list():select(2)
end, {
	noremap = true,
	silent = true,
	desc = "Quick Harpoon 2",
})

vim.keymap.set("n", "<M-k>", function()
	require("harpoon"):list():select(3)
end, {
	noremap = true,
	silent = true,
	desc = "Quick Harpoon 3",
})

vim.keymap.set("n", "<M-l>", function()
	require("harpoon"):list():select(4)
end, {
	noremap = true,
	silent = true,
	desc = "Quick Harpoon 4",
})

-- Cycle through marks
vim.keymap.set("n", "<leader>hn", function()
	require("harpoon"):list():next()
end, {
	noremap = true,
	silent = true,
	desc = "Next Harpoon mark",
})

vim.keymap.set("n", "<leader>hp", function()
	require("harpoon"):list():prev()
end, {
	noremap = true,
	silent = true,
	desc = "Previous Harpoon mark",
})

-- Alternative cycling with brackets
vim.keymap.set("n", "]h", function()
	require("harpoon"):list():next()
end, {
	noremap = true,
	silent = true,
	desc = "Next Harpoon mark",
})

vim.keymap.set("n", "[h", function()
	require("harpoon"):list():prev()
end, {
	noremap = true,
	silent = true,
	desc = "Previous Harpoon mark",
})

-- Clear all marks
vim.keymap.set("n", "<leader>hc", function()
	require("harpoon"):list():clear()
end, {
	noremap = true,
	silent = true,
	desc = "Clear all Harpoon marks",
})

-- Remove current file from Harpoon
vim.keymap.set("n", "<leader>hr", function()
	local harpoon = require("harpoon")
	local list = harpoon:list()
	local current_file = vim.api.nvim_buf_get_name(0)

	for i, item in ipairs(list.items) do
		if item.value == current_file then
			list:remove_at(i)
			break
		end
	end
end, {
	noremap = true,
	silent = true,
	desc = "Remove current file from Harpoon",
})

-- --- Flash ---
-- ---------------------------------------------------------------------------
-- Main jump motions
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, {
	noremap = true,
	silent = true,
	desc = "Flash jump",
})

vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, {
	noremap = true,
	silent = true,
	desc = "Flash treesitter",
})

-- Remote operations (operator mode only)
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, {
	noremap = true,
	silent = true,
	desc = "Remote flash",
})

vim.keymap.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, {
	noremap = true,
	silent = true,
	desc = "Treesitter search",
})

-- Toggle flash search in command mode
vim.keymap.set("c", "<c-s>", function()
	require("flash").toggle()
end, {
	noremap = true,
	silent = true,
	desc = "Toggle flash search",
})

-- --- Additional Motions ---
-- Jump to line
vim.keymap.set({ "n", "x", "o" }, "<leader>jl", function()
	require("flash").jump({
		search = { mode = "search", max_length = 0 },
		label = { after = { 0, 0 } },
		pattern = "^",
	})
end, {
	noremap = true,
	silent = true,
	desc = "Jump to line",
})

-- Jump to word beginning
vim.keymap.set({ "n", "x", "o" }, "<leader>jw", function()
	require("flash").jump({
		search = {
			mode = function(str)
				return "\\<" .. str
			end,
		},
	})
end, {
	noremap = true,
	silent = true,
	desc = "Jump to word beginning",
})

-- Continue last flash search
vim.keymap.set({ "n", "x", "o" }, "<leader>j.", function()
	require("flash").jump({ continue = true })
end, {
	noremap = true,
	silent = true,
	desc = "Continue last flash",
})

-- Directional jumps
vim.keymap.set({ "n", "x", "o" }, "<leader>jf", function()
	require("flash").jump({
		search = { forward = true, wrap = false, multi_window = false },
	})
end, {
	noremap = true,
	silent = true,
	desc = "Flash forward only",
})

vim.keymap.set({ "n", "x", "o" }, "<leader>jb", function()
	require("flash").jump({
		search = { forward = false, wrap = false, multi_window = false },
	})
end, {
	noremap = true,
	silent = true,
	desc = "Flash backward only",
})

-- Select any word (visual/operator mode)
vim.keymap.set({ "x", "o" }, "<leader>jW", function()
	require("flash").jump({
		pattern = ".",
		search = {
			mode = function(pattern)
				-- Remove leading dot
				if pattern:sub(1, 1) == "." then
					pattern = pattern:sub(2)
				end
				-- Return word pattern and skip pattern
				return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
			end,
		},
		jump = { pos = "range" },
	})
end, {
	noremap = true,
	silent = true,
	desc = "Flash select word",
})

-- --- Marks [m] ---
-- ---------------------------------------------------------------------------

-- Letter marks
vim.keymap.set("n", "<leader>ma", function()
	require("marks").set()
end, {
	noremap = true,
	silent = true,
	desc = "Set mark (wait for letter)",
})

-- Set next
vim.keymap.set("n", "<leader>m,", function()
	require("marks").set_next()
end, {
	noremap = true,
	silent = true,
	desc = "Set next available mark",
})

-- Toggle mark at current line
vim.keymap.set("n", "<leader>m;", function()
	require("marks").toggle()
end, {
	noremap = true,
	silent = true,
	desc = "Toggle mark at line",
})

-- Delete marks
vim.keymap.set("n", "<leader>m<space>", function()
	require("marks").delete_line()
end, {
	noremap = true,
	silent = true,
	desc = "Delete mark on line",
})

vim.keymap.set("n", "<leader>mD", function()
	require("marks").delete_buf()
end, {
	noremap = true,
	silent = true,
	desc = "Delete all marks in buffer",
})

-- Navigation
vim.keymap.set("n", "<leader>m]", function()
	require("marks").next()
end, {
	noremap = true,
	silent = true,
	desc = "Next mark",
})

vim.keymap.set("n", "<leader>m[", function()
	require("marks").prev()
end, {
	noremap = true,
	silent = true,
	desc = "Previous mark",
})

vim.keymap.set("n", "<leader>m:", function()
	require("marks").preview()
end, {
	noremap = true,
	silent = true,
	desc = "Preview mark",
})

-- Delete mark by letter
vim.keymap.set("n", "<leader>md", function()
	require("marks").delete()
end, {
	noremap = true,
	silent = true,
	desc = "Delete mark (wait for letter)",
})

-- Bracket navigation without leader
vim.keymap.set("n", "]m", function()
	require("marks").next()
end, {
	noremap = true,
	silent = true,
	desc = "Next mark",
})

vim.keymap.set("n", "[m", function()
	require("marks").prev()
end, {
	noremap = true,
	silent = true,
	desc = "Previous mark",
})

-- --- Yazi [y] ---
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>yc", "<cmd>Yazi<CR>", {
	noremap = true,
	silent = true,
	desc = "Open Yazi at current file",
})

vim.keymap.set("n", "<leader>yw", "<cmd>Yazi cwd<CR>", {
	noremap = true,
	silent = true,
	desc = "Open Yazi on nvim working directory",
})

vim.keymap.set("n", "<leader>yr", "<cmd>Yazi toggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Resume yazi",
})

-- --- Outline/Aerial Operations [o] ---
-- ---------------------------------------------------------------------------
-- Main outline toggles
vim.keymap.set("n", "<leader>oa", "<cmd>AerialToggle!<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle sidebar",
})

vim.keymap.set("n", "<leader>oA", "<cmd>AerialNavToggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle navigation",
})

-- --- Additional Outline Operations ---
vim.keymap.set("n", "<leader>of", function()
	require("aerial").toggle()
	if require("aerial").is_open() then
		require("aerial").focus()
	end
end, {
	noremap = true,
	silent = true,
	desc = "Focus sidebar",
})

-- --- Quick Symbol Navigation (when Aerial Is Open) ---
vim.keymap.set("n", "{", "<cmd>AerialNext<CR>", {
	noremap = true,
	silent = true,
	desc = "Next symbol",
})

vim.keymap.set("n", "}", "<cmd>AerialPrev<CR>", {
	noremap = true,
	silent = true,
	desc = "Previous symbol",
})

-- --- Comment ---
-- ---------------------------------------------------------------------------
-- Comment header
-- FIX: Does not work on languages such as CSS, where there is comment open and close
vim.keymap.set("n", "<Leader>ch", functions.comment_header, {
	noremap = true,
	silent = true,
	desc = "Append",
})

-- Comment toggle
vim.keymap.set("n", "<leader>cc", function()
	if vim.v.count == 0 then
		-- No count given, toggle current line
		require("Comment.api").toggle.linewise.current()
	else
		-- Count given, toggle 'count' lines
		require("Comment.api").toggle.linewise.count(vim.v.count)
	end
end, { desc = "Toggle Linewise (Line/Count)" })

-- Comment linewise
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
vim.keymap.set("x", "<leader>cc", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle Linewise (Visual Selection)" })

-- Comment append
vim.keymap.set("n", "<Leader>ca", functions.comment_append, {
	noremap = true,
	silent = true,
	desc = "Append",
})

vim.keymap.set("n", "<Leader>ct", functions.insert_todo, {
	noremap = true,
	silent = true,
	desc = "Insert TODO",
})

-- Insert FIX
vim.keymap.set("n", "<Leader>cf", functions.insert_fix, {
	noremap = true,
	silent = true,
	desc = "Insert FIX",
})

-- Insert NOTE
vim.keymap.set("n", "<Leader>cn", functions.insert_note, {
	noremap = true,
	silent = true,
	desc = "Insert NOTE",
})

-- Insert HACK
vim.keymap.set("n", "<Leader>ck", functions.insert_hack, {
	noremap = true,
	silent = true,
	desc = "Insert HACK",
})

-- Insert WARN
vim.keymap.set("n", "<Leader>cw", functions.insert_warn, {
	noremap = true,
	silent = true,
	desc = "Insert WARN",
})

-- Insert PERF
vim.keymap.set("n", "<Leader>cp", functions.insert_perf, {
	noremap = true,
	silent = true,
	desc = "Insert PERF",
})

-- Insert TEST
vim.keymap.set("n", "<Leader>ce", functions.insert_test, {
	noremap = true,
	silent = true,
	desc = "Insert TEST",
})

-- Insert DOCS
vim.keymap.set("n", "<Leader>cd", functions.insert_test, {
	noremap = true,
	silent = true,
	desc = "Insert DOCS",
})

-- Insert DONE
vim.keymap.set("n", "<Leader>cD", functions.insert_test, {
	noremap = true,
	silent = true,
	desc = "Insert DONE",
})

-- Swaps [S]
vim.keymap.set("n", "<Leader>csd", functions.toggle_todo_done, {
	noremap = true,
	silent = true,
	desc = "Swap TODO/DONE",
})

-- Utils
vim.keymap.set("n", "<Leader>cl", functions.list_buffer_todos, {
	noremap = true,
	silent = true,
	desc = "List buffer TODOs",
})

-- Edit
vim.keymap.set("n", "<Leader>er", functions.replace_buffer_with_clipboard, {
	noremap = true,
	silent = true,
	desc = "Replace buffer with clipboard",
})

-- Smart replace
vim.keymap.set({ "n", "v" }, "<leader>rr", functions.smart_replace, {
	noremap = true,
	silent = true,
	desc = "Replace normal or visual smartly and with prompt to user",
})

-- --- Replace (spectre) ---
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>rt", functions.spectre_toggle, {
	desc = "Toggle Spectre",
})

vim.keymap.set("n", "<leader>rw", functions.spectre_open_visual_word, {
	desc = "Search current word",
})

vim.keymap.set("v", "<leader>rw", functions.spectre_open_visual, {
	desc = "Search current word",
})

vim.keymap.set("n", "<leader>rf", functions.spectre_open_file_search, {
	desc = "Search on current file",
})

-- --- Lsp Actions (direct Actions That Do Something) ---
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Show hover" })
-- Format
vim.keymap.set({ "n", "v" }, "<Leader>lf", functions.format_with_conform, {
	noremap = true,
	silent = true,
	desc = "Format (Conform)",
})

vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code actions" })

-- --- Lsp Navigation (go To Things - Quick Jumps) ---
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to references" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Go to type definition" })

-- --- Find/search (interactive Pickers And Browsers) ---
-- ---------------------------------------------------------------------------
-- Find files on current dir
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })

-- Find files on root project
vim.keymap.set("n", "<leader>fF", functions.find_files_in_project, {
	desc = "Find files on current project",
})

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fr", function()
	require("telescope").extensions.frecency.frecency()
end, { desc = "Recent (Frecency)" })

vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Word under cursor" })

-- Diagnostics browsing
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics (current file)" })
vim.keymap.set("n", "<leader>fD", function()
	builtin.diagnostics({ bufnr = nil })
end, { desc = "Diagnostics (all files)" })

-- LSP symbol browsing
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Symbols (document)" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Symbols (workspace)" })

-- Vim internals
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fo", builtin.vim_options, { desc = "Options" })
vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command history" })
vim.keymap.set("n", "<leader>fH", builtin.search_history, { desc = "Search history" })

-- TODO on current file
vim.keymap.set("n", "<leader>ft", functions.find_todos_in_buffer, {
	desc = "Find TODOs on current buffer using priority",
})

-- TODO on root project
vim.keymap.set("n", "<leader>fT", functions.find_todos_in_project, {
	desc = "Find TODOs on current buffer using priority",
})

-- Live grep with args on current file
vim.keymap.set("n", "<leader>fg", functions.live_grep_args, {
	desc = "Live grep with args",
})

-- Live grep with args on root project
vim.keymap.set("n", "<leader>fG", functions.live_grep_in_project, {
	desc = "Live grep with args on current root project",
})

-- Aerial
vim.keymap.set("n", "<leader>fa", functions.aerial_symbols, {
	noremap = true,
	silent = true,
	desc = "Aerial symbols",
})

-- --- Trouble (visual Problem Browser) ---
-- ---------------------------------------------------------------------------
-- Core trouble toggles
vim.keymap.set("n", "<leader>tt", functions.trouble_toggle_diagnostics, {
	desc = "Toggle diagnostics",
})

vim.keymap.set("n", "<leader>tb", functions.trouble_toggle_buffer_diagnostics, {
	desc = "Buffer diagnostics",
})

vim.keymap.set("n", "<leader>tq", "<cmd>copen<CR>", {
	noremap = true,
	silent = true,
	desc = "Quickfix list",
})

vim.keymap.set("n", "<leader>tl", functions.trouble_toggle_loclist, {
	desc = "Location list",
})

-- LSP-related trouble views
vim.keymap.set("n", "<leader>tr", functions.trouble_toggle_references, {
	desc = "LSP references",
})

vim.keymap.set("n", "<leader>td", functions.trouble_toggle_definitions, {
	desc = "LSP definitions",
})

vim.keymap.set("n", "<leader>ti", functions.trouble_toggle_implementations, {
	desc = "LSP implementations",
})

vim.keymap.set("n", "<leader>ts", functions.trouble_toggle_symbols, {
	desc = "Document symbols",
})

-- Trouble control
vim.keymap.set("n", "<leader>tc", functions.trouble_close, {
	desc = "Close all",
})

-- --- Trouble Navigation (no Leader - Direct Access) ---
vim.keymap.set("n", "]T", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Next trouble item" })
vim.keymap.set("n", "[T", function()
	require("trouble").prev({ skip_groups = true, jump = true })
end, { desc = "Previous trouble item" })
vim.keymap.set("n", "g]T", function()
	require("trouble").last({ skip_groups = true, jump = true })
end, { desc = "Last trouble item" })
vim.keymap.set("n", "g[T", function()
	require("trouble").first({ skip_groups = true, jump = true })
end, { desc = "First trouble item" })

-- --- Diagnostics ---
vim.keymap.set("n", "<Leader>dv", functions.toggle_virtual_text, {
	noremap = true,
	silent = true,
	desc = "Toggle virtual text",
})

vim.keymap.set("n", "<Leader>dl", functions.show_line_diagnostics, {
	noremap = true,
	silent = true,
	desc = "Show line diagnostics",
})

vim.keymap.set("n", "<Leader>db", functions.show_buffer_diagnostics, {
	noremap = true,
	silent = true,
	desc = "Show buffer diagnostics",
})

vim.keymap.set("n", "]d", functions.goto_next_diagnostic, {
	noremap = true,
	silent = true,
	desc = "Next diagnostic",
})

vim.keymap.set("n", "[d", functions.goto_prev_diagnostic, {
	noremap = true,
	silent = true,
	desc = "Previous diagnostic",
})

vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, {
	noremap = true,
	silent = true,
	desc = "Next error",
})

vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, {
	noremap = true,
	silent = true,
	desc = "Previous error",
})

-- Auto-show diagnostics on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
	callback = function()
		-- Only show if not in insert mode
		if vim.fn.mode() ~= "i" then
			vim.diagnostic.open_float(nil, {
				focus = false,
				scope = "cursor",
				border = "single",
				source = "always",
			})
		end
	end,
})

-- Indents
-- ---------------------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "<Leader>ii", functions.smart_indent, {
	noremap = true,
	silent = true,
	desc = "Smart indent line/selection",
})

vim.keymap.set({ "n", "v" }, "<Leader>io", functions.smart_outdent, {
	noremap = true,
	silent = true,
	desc = "Smart outdent line/selection",
})

-- Buffers
-- ---------------------------------------------------------------------------
-- Scroll buffers
vim.keymap.set({ "n", "v" }, "<M-s>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set({ "n", "v" }, "<M-S>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })

-- Write and close buffers
vim.keymap.set("n", "<leader>w", functions.smart_save_and_close, {
	desc = "Save and close (smart)",
	silent = true,
})

-- Close buffer without writing
vim.keymap.set("n", "<leader>q", functions.smart_close_buffer, {
	desc = "Close without saving (smart)",
	silent = true,
})

-- Move buffers
vim.keymap.set("n", "<leader>bmn", "<cmd>BufferLineMoveNext<CR>", { desc = "Move next", silent = true })
vim.keymap.set("n", "<leader>bmp", "<cmd>BufferLineMovePrev<CR>", { desc = "Move prev", silent = true })

-- Go to buffer by number
vim.keymap.set("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1", silent = true })
vim.keymap.set("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2", silent = true })
vim.keymap.set("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3", silent = true })
vim.keymap.set("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4", silent = true })
vim.keymap.set("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5", silent = true })
vim.keymap.set("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6", silent = true })
vim.keymap.set("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7", silent = true })
vim.keymap.set("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8", silent = true })
vim.keymap.set("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9", silent = true })

-- Close buffers
vim.keymap.set("n", "<leader>bcp", "<cmd>BufferLinePickClose<CR>", { desc = "Pick to close", silent = true })
vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close others", silent = true })

-- Close buffers in direction
vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<CR>", { desc = "Close to right", silent = true })
vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close to left", silent = true })

-- Pick buffer
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick", silent = true })

-- Pin/unpin buffer
vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin", silent = true })

-- Sort buffers
vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort by directory", silent = true })
vim.keymap.set("n", "<leader>bse", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort by extension", silent = true })
vim.keymap.set("n", "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", { desc = "Sort by tabs", silent = true })

-- Buffer groups
vim.keymap.set(
	"n",
	"<leader>bgt",
	"<cmd>BufferLineGroupToggle Tests<CR>",
	{ desc = "Toggle Tests group", silent = true }
)

vim.keymap.set("n", "<leader>bgd", "<cmd>BufferLineGroupToggle Docs<CR>", { desc = "Toggle Docs group", silent = true })

-- Git integration
-- -------------------------------------------------
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Branches" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Status" })

-- TODOs Navigation
-- -------------------------------------------------
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "]T", function()
	require("todo-comments").jump_next({ keywords = { "TODO", "FIX", "SEV1", "SEV2", "SEV3" } })
end, { desc = "Next task" })

-- --- Multicursor [M] ---
-- ---------------------------------------------------------------------------
-- Core multicursor operations
vim.keymap.set({ "n", "v" }, "<Leader>M", "<cmd>MCvisual<CR>", {
	noremap = true,
	silent = true,
	desc = "Start on word/selection",
})

-- --- Noice [x] ---
-- ---------------------------------------------------------------------------
-- Command line redirect
vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, {
	noremap = true,
	silent = true,
	desc = "Redirect Cmdline",
})

-- Main noice commands
vim.keymap.set("n", "<leader>xnl", function()
	require("noice").cmd("last")
end, {
	noremap = true,
	silent = true,
	desc = "Noice Last Message",
})

vim.keymap.set("n", "<leader>xnh", function()
	require("noice").cmd("history")
end, {
	noremap = true,
	silent = true,
	desc = "Noice History",
})

vim.keymap.set("n", "<leader>xna", function()
	require("noice").cmd("all")
end, {
	noremap = true,
	silent = true,
	desc = "Noice All",
})

vim.keymap.set("n", "<leader>xnd", function()
	require("noice").cmd("dismiss")
end, {
	noremap = true,
	silent = true,
	desc = "Dismiss All",
})

vim.keymap.set("n", "<leader>xnt", function()
	require("noice").cmd("pick")
end, {
	noremap = true,
	silent = true,
	desc = "Noice Picker (Telescope/FzfLua)",
})

-- LSP scroll functions
vim.keymap.set({ "i", "n", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, {
	noremap = true,
	silent = true,
	expr = true,
	desc = "Scroll Forward",
})

vim.keymap.set({ "i", "n", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, {
	noremap = true,
	silent = true,
	expr = true,
	desc = "Scroll Backward",
})

-- Sort
-- -------------------------------------------------
-- Sort variations
vim.keymap.set("v", "<Leader>sa", ":sort<CR>", { noremap = true, silent = true, desc = "Sort alphabetically" })
vim.keymap.set("v", "<Leader>sr", ":sort!<CR>", { noremap = true, silent = true, desc = "Sort reverse (descending)" })
vim.keymap.set("v", "<Leader>si", ":sort i<CR>", { noremap = true, silent = true, desc = "Sort case-insensitive" })
vim.keymap.set("v", "<Leader>sn", ":sort n<CR>", { noremap = true, silent = true, desc = "Sort numerically" })

-- Motions
-- -------------------------------------------------
-- Move lines up/down
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-- Inserts
-- -------------------------------------------------
-- Insert new line below without insert mode
vim.keymap.set("n", "<CR>", "m`o<Esc>``")
-- Insert new line above without insert mode
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

-- LuaSnip (Snippets)
-- TODO: Add this

-- vim.keymap.set("n", "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", { desc = "Sort by tabs", silent = true })
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })

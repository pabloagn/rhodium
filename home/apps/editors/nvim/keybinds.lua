local functions = require("functions")
local builtin = require("telescope.builtin")

-- Leaders
-- -------------------------------------------------
vim.g.mapleader = " " -- Leader
vim.g.maplocalleader = " " -- Local leader

-- General
-- -------------------------------------------------
-- TODO: Reassign this key to a more productive map
-- vim.keymap.set(
-- 	"n",
-- 	"<Leader><space>",
-- 	"<cmd>noh<CR>",
-- 	{ noremap = true, silent = true, desc = "Clear search highlight" }
-- )
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })
vim.keymap.set(
	"n",
	"<Leader>n",
	"<cmd>set nu! rnu!<CR>",
	{ noremap = true, silent = true, desc = "Toggle line numbers" }
)
vim.keymap.set("n", "<Leader>y", ":%y+<CR>", { noremap = true, silent = true, desc = "Copy entire buffer to clip" })
vim.keymap.set("n", "<Leader>D", ":%d+<CR>", { noremap = true, silent = true, desc = "Delete entire buffer" })

-- Yazi
-- -------------------------------------------------
vim.keymap.set("n", "<leader>ac", "<cmd>Yazi<CR>", {
	noremap = true,
	silent = true,
	desc = "Open Yazi on current directory",
})

vim.keymap.set("n", "<leader>aw", "<cmd>Yazi<CR>", {
	noremap = true,
	silent = true,
	desc = "Open Yazi on working directory",
})

-- Outline/Aerial Operations
-- -------------------------------------------------
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

-- Built-in outline (alternative to Aerial)
-- vim.keymap.set("n", "gO", "<cmd>AerialNavOpen<CR>", {
-- 	noremap = true,
-- 	silent = true,
-- 	desc = "Open navigation",
-- })

-- Additional outline operations
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

-- Quick symbol navigation (when aerial is open)
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

-- Alternative: Use telescope for symbol search
-- vim.keymap.set("n", "<leader>as", function()
-- 	require("telescope").extensions.aerial.aerial()
-- end, {
-- 	noremap = true,
-- 	silent = true,
-- 	desc = "Search symbols",
-- })

-- Comment
-- -------------------------------------------------
-- Comment header
vim.keymap.set("n", "<Leader>ch", function()
	functions.comment_header()
end, {
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
vim.keymap.set("n", "<Leader>ca", function()
	functions.comment_append()
end, {
	noremap = true,
	silent = true,
	desc = "Append",
})

-- Comment all lines
vim.keymap.set("n", "<leader>cA", function()
	local line_count = vim.api.nvim_buf_line_count(0)
	require("Comment.api").toggle.linewise.count(line_count)
end, { desc = "Comment all lines" })

vim.keymap.set("n", "<Leader>ct", function()
	functions.insert_todo()
end, {
	noremap = true,
	silent = true,
	desc = "Insert TODO",
})

-- Insert FIX
vim.keymap.set("n", "<Leader>cf", function()
	functions.insert_fix()
end, {
	noremap = true,
	silent = true,
	desc = "Insert FIX",
})

-- Insert NOTE
vim.keymap.set("n", "<Leader>cn", function()
	functions.insert_note()
end, {
	noremap = true,
	silent = true,
	desc = "Insert NOTE",
})

-- Insert HACK
vim.keymap.set("n", "<Leader>ck", function()
	functions.insert_hack()
end, {
	noremap = true,
	silent = true,
	desc = "Insert HACK",
})

-- Insert WARN
vim.keymap.set("n", "<Leader>cw", function()
	functions.insert_warn()
end, {
	noremap = true,
	silent = true,
	desc = "Insert WARN",
})

-- Insert PERF
vim.keymap.set("n", "<Leader>cp", function()
	functions.insert_perf()
end, {
	noremap = true,
	silent = true,
	desc = "Insert PERF",
})

-- Insert TEST
vim.keymap.set("n", "<Leader>ce", function()
	functions.insert_test()
end, {
	noremap = true,
	silent = true,
	desc = "Insert TEST",
})

-- Insert DOCS
vim.keymap.set("n", "<Leader>cd", function()
	functions.insert_test()
end, {
	noremap = true,
	silent = true,
	desc = "Insert DOCS",
})

-- Insert DONE
vim.keymap.set("n", "<Leader>cD", function()
	functions.insert_test()
end, {
	noremap = true,
	silent = true,
	desc = "Insert DONE",
})

-- Swaps [S]
vim.keymap.set("n", "<Leader>csd", function()
	functions.toggle_todo_done()
end, {
	noremap = true,
	silent = true,
	desc = "Swap TODO/DONE",
})

-- Utils
vim.keymap.set("n", "<Leader>cl", function()
	functions.list_buffer_todos()
end, {
	noremap = true,
	silent = true,
	desc = "List buffer TODOs",
})

-- Edit
-- -------------------------------------------------
vim.keymap.set("n", "<Leader>er", function()
	functions.replace_buffer_with_clipboard()
end, {
	noremap = true,
	silent = true,
	desc = "Replace buffer with clipboard",
})

-- Smart Replace
-- -------------------------------------------------
vim.keymap.set({ "n", "v" }, "<leader>rv", functions.smart_replace, {
	noremap = true,
	silent = false,
	desc = "Replace word/selection in buffer",
})

-- Replace (Spectre)
-- -------------------------------------------------
vim.keymap.set("n", "<leader>rt", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})

vim.keymap.set("n", "<leader>rw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})

vim.keymap.set("v", "<leader>rw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})

vim.keymap.set("n", "<leader>rf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

-- LSP Actions (Direct actions that do something)
-- -------------------------------------------------
vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Show hover" })
vim.keymap.set({ "n", "v" }, "<Leader>lf", function()
	require("conform").format()
end, {
	noremap = true,
	silent = true,
	desc = "Format (Conform)",
})

vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code actions" })

-- LSP Navigation (Go to things - quick jumps)
-- -------------------------------------------------
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to references" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Go to type definition" })

-- Find/Search (Interactive pickers and browsers)
-- -------------------------------------------------
-- Files and project
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
vim.keymap.set("n", "<Leader>fp", function()
	functions.find_files_in_project()
end, {
	noremap = true,
	silent = true,
	desc = "Project files",
})

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fr", function()
	require("telescope").extensions.frecency.frecency()
end, { desc = "Recent (Frecency)" })

-- Text search
vim.keymap.set("n", "<leader>fg", function()
	require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Live grep with args" })
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

-- Special finders
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=FIX,TODO,PERF,TEST<CR>", {
	noremap = true,
	silent = true,
	desc = "TODOs with priority sorting",
})

-- Trouble (Visual problem browser)
-- -------------------------------------------------
-- Core trouble toggles
vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle("diagnostics")
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>tb", function()
	require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
end, { desc = "Buffer diagnostics" })

vim.keymap.set("n", "<leader>tq", "<cmd>copen<CR>", {
	noremap = true,
	silent = true,
	desc = "Quickfix list",
})

vim.keymap.set("n", "<leader>tl", function()
	require("trouble").toggle("loclist")
end, { desc = "Location list" })

-- LSP-related trouble views
vim.keymap.set("n", "<leader>tr", function()
	require("trouble").toggle("lsp_references")
end, { desc = "LSP references" })

vim.keymap.set("n", "<leader>td", function()
	require("trouble").toggle("lsp_definitions")
end, { desc = "LSP definitions" })

vim.keymap.set("n", "<leader>ti", function()
	require("trouble").toggle("lsp_implementations")
end, { desc = "LSP implementations" })

vim.keymap.set("n", "<leader>ts", function()
	require("trouble").toggle("symbols")
end, { desc = "Document symbols" })

-- Trouble controls
vim.keymap.set("n", "<leader>tc", function()
	require("trouble").close()
end, { desc = "Close all" })

-- Trouble Navigation (No leader - direct access)
-- -------------------------------------------------
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

-- Diagnostics
-- -------------------------------------------------
vim.keymap.set("n", "<Leader>dv", function()
	functions.toggle_virtual_text()
end, {
	noremap = true,
	silent = true,
	desc = "Toggle virtual text",
})

vim.keymap.set("n", "<Leader>dl", function()
	functions.show_line_diagnostics()
end, {
	noremap = true,
	silent = true,
	desc = "Show line diagnostics",
})

vim.keymap.set("n", "<Leader>db", function()
	functions.show_buffer_diagnostics()
end, {
	noremap = true,
	silent = true,
	desc = "Show buffer diagnostics",
})

vim.keymap.set("n", "]d", function()
	functions.goto_next_diagnostic()
end, {
	noremap = true,
	silent = true,
	desc = "Next diagnostic",
})

vim.keymap.set("n", "[d", function()
	functions.goto_prev_diagnostic()
end, {
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
-- -------------------------------------------------
vim.keymap.set({ "n", "v" }, "<Leader>ii", function()
	functions.smart_indent()
end, {
	noremap = true,
	silent = true,
	desc = "Smart indent line/selection",
})

vim.keymap.set({ "n", "v" }, "<Leader>io", function()
	functions.smart_outdent()
end, {
	noremap = true,
	silent = true,
	desc = "Smart outdent line/selection",
})

-- Treesitter
-- -------------------------------------------------
vim.keymap.set("n", "<Leader>z", ":set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle Treesitter folding",
})

-- Buffers
-- -------------------------------------------------
-- Scroll buffers
vim.keymap.set({ "n", "v" }, "<M-s>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set({ "n", "v" }, "<M-S>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })

-- Close buffers
-- TODO: Validate
-- vim.keymap.set("n", "<leader>w", "<cmd>write | bdelete<CR>", { desc = "Save and close", silent = true })
-- vim.keymap.set("n", "<leader>q", "<cmd>bdelete!<CR>", { desc = "Close without saving", silent = true })

-- Smart close buffers
-- TODO: Validate
vim.keymap.set("n", "<leader>w", functions.smart_save_and_close, {
	desc = "Save and close (smart)",
	silent = true,
})

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

-- Multicursor
-- -------------------------------------------------
-- Core multicursor operations
vim.keymap.set({ "n", "v" }, "<Leader>m", "<cmd>MCvisual<CR>", {
	noremap = true,
	silent = true,
	desc = "Start on word/selection",
})

-- Noice
-- -------------------------------------------------
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
vim.keymap.set("n", "<CR>", "m`o<Esc>``") -- Insert new line below without insert mode
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

-- LuaSnip (Snippets)
-- TODO: Add this

-- vim.keymap.set("n", "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", { desc = "Sort by tabs", silent = true })
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })

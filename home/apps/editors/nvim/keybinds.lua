local functions = require('functions')
local builtin = require('telescope.builtin')

-- Leaders
vim.g.mapleader = ' '      -- Leader
vim.g.maplocalleader = ' ' -- Local leader

-- General
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>', { noremap = true, silent = true, desc = 'Toggle line numbers' })
vim.keymap.set('n', '<Leader>y', ':%y+<CR>', { noremap = true, silent = true, desc = 'Copy entire buffer to clip' })
vim.keymap.set('n', '<Leader>d', ':%d+<CR>', { noremap = true, silent = true, desc = 'Delete entire buffer' })

-- Comment
vim.keymap.set('v', '<Leader>cc', ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ noremap = true, silent = true, desc = 'Comment Comment: Toggle comment for visual' })
vim.keymap.set('n', '<Leader>cc', ":lua require('Comment.api').toggle.linewise.current()<CR>",
	{ noremap = true, silent = true, desc = 'Comment Comment: Toggle comment for current' })
vim.keymap.set('n', '<Leader>ct', 'o-- TODO: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment TODO: Insert TODO comment' })
vim.keymap.set('n', '<Leader>cb', 'o-- BUG: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment BUG: Insert BUG comment' })
vim.keymap.set('n', '<Leader>cn', 'o-- NOTE: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment NOTE: Insert NOTE comment' })
vim.keymap.set('n', '<Leader>cd', 'o-- DONE: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment DONE: Insert DONE comment' })
vim.keymap.set('n', '<Leader>ch', 'o-- HACK: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment HACK: Insert HACK comment' })
vim.keymap.set('n', '<Leader>cw', 'o-- WARN: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment WARN: Insert WARN comment' })
vim.keymap.set('n', '<Leader>cp', 'o-- PERF: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment PERF: Insert PERF comment' })
vim.keymap.set('n', '<Leader>ce', 'o-- TEST: <Esc>A',
	{ noremap = true, silent = true, desc = 'Comment TEST: Insert TEST comment' })

-- Edit
vim.keymap.set('n', '<Leader>er', function() functions.replace_buffer_with_clipboard() end,
	{ noremap = true, silent = true, desc = 'Edit Replace: Replace buffer with clipboard content' })

-- VimTeX (LaTeX Editing)
vim.keymap.set('n', '<Leader>ll', '<Plug>(vimtex-compile)',
	{ noremap = true, silent = true, desc = "VimTeX continuous compile" })
vim.keymap.set('n', '<Leader>lv', '<Plug>(vimtex-view)', { noremap = true, silent = true, desc = "VimTeX View PDF" })
vim.keymap.set('n', '<Leader>lt', '<Plug>(vimtex-toc-toggle)',
	{ noremap = true, silent = true, desc = "VimTeX Toggle TOC" })

-- Multicursors.nvim (Multiple cursors)
-- vim.keymap.set('n', '<Leader>m', '<cmd>MCstart<cr>', { noremap = true, silent = true, desc = 'Create a selection for selected text or word under the cursor' })

-- Treesitter (Syntax highlighting)
vim.keymap.set('n', '<Leader>z', ':set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()<CR>',
	{ noremap = true, silent = true, desc = 'Toggle Treesitter folding' })

-- LuaSnip (Snippets)
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })

vim.keymap.set({ 'n', 'v' }, '<Leader>ii', function() functions.smart_indent() end, {
	noremap = true,
	silent = true,
	desc = 'Indent Indent: Smart indent line/selection'
})

vim.keymap.set({ 'n', 'v' }, '<Leader>io', function() functions.smart_outdent() end, {
	noremap = true,
	silent = true,
	desc = 'Indent Outdent: Smart outdent line/selection'
})

-- Find
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files: Find files' })
vim.keymap.set('n', '<leader>fg', function()
	require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = 'Live grep with args' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffer: Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help: Find help' })
vim.keymap.set('n', '<leader>fr', function()
	require('telescope').extensions.frecency.frecency()
end, { desc = 'Recent files (frecency)' })

-- Advanced search
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = 'Search history' })

-- Advanced pickers
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Vim options' })
vim.keymap.set('n', '<leader>ft', function() functions.todo_picker() end,
	{ noremap = true, silent = true, desc = 'Find TODOs: TODO picker with priority sorting' })

-- Buffers
-- -------------------------------------------------
-- Navigate buffers
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
vim.keymap.set('n', '<leader>bl', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<leader>bh', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })

-- Move buffers
vim.keymap.set('n', '<leader>bmn', ':BufferLineMoveNext<CR>', { desc = 'Move buffer next', silent = true })
vim.keymap.set('n', '<leader>bmp', ':BufferLineMovePrev<CR>', { desc = 'Move buffer prev', silent = true })

-- Go to buffer by number
vim.keymap.set('n', '<leader>b1', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Go to buffer 1', silent = true })
vim.keymap.set('n', '<leader>b2', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Go to buffer 2', silent = true })
vim.keymap.set('n', '<leader>b3', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Go to buffer 3', silent = true })
vim.keymap.set('n', '<leader>b4', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Go to buffer 4', silent = true })
vim.keymap.set('n', '<leader>b5', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Go to buffer 5', silent = true })
vim.keymap.set('n', '<leader>b6', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Go to buffer 6', silent = true })
vim.keymap.set('n', '<leader>b7', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Go to buffer 7', silent = true })
vim.keymap.set('n', '<leader>b8', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Go to buffer 8', silent = true })
vim.keymap.set('n', '<leader>b9', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Go to buffer 9', silent = true })

-- Close buffers
vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Pick buffer to close', silent = true })
vim.keymap.set('n', '<leader>bC', ':BufferLineCloseOthers<CR>', { desc = 'Close other buffers', silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer', silent = true })
vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete buffer', silent = true })

-- Close buffers in direction
vim.keymap.set('n', '<leader>bcr', ':BufferLineCloseRight<CR>', { desc = 'Close buffers to right', silent = true })
vim.keymap.set('n', '<leader>bcl', ':BufferLineCloseLeft<CR>', { desc = 'Close buffers to left', silent = true })

-- Pick buffer
vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer', silent = true })

-- Pin/unpin buffer
vim.keymap.set('n', '<leader>bP', ':BufferLineTogglePin<CR>', { desc = 'Toggle pin buffer', silent = true })

-- Sort buffers
vim.keymap.set('n', '<leader>bsd', ':BufferLineSortByDirectory<CR>', { desc = 'Sort by directory', silent = true })
vim.keymap.set('n', '<leader>bse', ':BufferLineSortByExtension<CR>', { desc = 'Sort by extension', silent = true })
vim.keymap.set('n', '<leader>bst', ':BufferLineSortByTabs<CR>', { desc = 'Sort by tabs', silent = true })

-- Buffer groups
vim.keymap.set('n', '<leader>bgt', ':BufferLineGroupToggle Tests<CR>', { desc = 'Toggle test group', silent = true })
vim.keymap.set('n', '<leader>bgd', ':BufferLineGroupToggle Docs<CR>', { desc = 'Toggle docs group', silent = true })

-- Git integration
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

-- Diagnostics (LSP)
vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'Show hover information' })
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code' })
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'Rename symbol' })
-- vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP implementations' })
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })

-- Diagnostics
vim.keymap.set('n', '<leader>xx', builtin.diagnostics, { desc = 'Diagnostics' })

-- Trouble
-- ---------------------------------------------------------------
-- Primary diagnostic toggles
vim.keymap.set('n', '<leader>td', function() require("trouble").toggle("diagnostics") end,
	{ desc = "Toggle Diagnostics (Trouble)" })
vim.keymap.set('n', '<leader>tb', function() require("trouble").toggle("diagnostics", { filter = { buf = 0 } }) end,
	{ desc = "Toggle Buffer Diagnostics (Trouble)" })

-- LSP references and definitions
vim.keymap.set('n', '<leader>tr', function() require("trouble").toggle("lsp_references") end,
	{ desc = "Toggle LSP References (Trouble)" })
vim.keymap.set('n', '<leader>tD', function() require("trouble").toggle("lsp_definitions") end,
	{ desc = "Toggle LSP Definitions (Trouble)" })
vim.keymap.set('n', '<leader>ti', function() require("trouble").toggle("lsp_implementations") end,
	{ desc = "Toggle LSP Implementations (Trouble)" })
vim.keymap.set('n', '<leader>tt', function() require("trouble").toggle("lsp_type_definitions") end,
	{ desc = "Toggle LSP Type Definitions (Trouble)" })

-- Document symbols
vim.keymap.set('n', '<leader>ts', function() require("trouble").toggle("symbols") end,
	{ desc = "Toggle Symbols (Trouble)" })

-- Quickfix and location lists
vim.keymap.set('n', '<leader>tq', function() require("trouble").toggle("qflist") end,
	{ desc = "Toggle Quickfix (Trouble)" })
vim.keymap.set('n', '<leader>tl', function() require("trouble").toggle("loclist") end,
	{ desc = "Toggle Location List (Trouble)" })

-- Close all trouble windows
vim.keymap.set('n', '<leader>tc', function() require("trouble").close() end, { desc = "Close Trouble" })

-- Custom modes
vim.keymap.set('n', '<leader>tp', function() require("trouble").toggle("project_diagnostics") end,
	{ desc = "Project Diagnostics (Trouble)" })

-- Navigation within trouble - using ']T' and '[T' to avoid conflicts with your todo mappings
vim.keymap.set('n', ']T', function() require("trouble").next({ skip_groups = true, jump = true }) end,
	{ desc = "Next Trouble Item" })
vim.keymap.set('n', '[T', function() require("trouble").prev({ skip_groups = true, jump = true }) end,
	{ desc = "Previous Trouble Item" })

-- Advanced navigation
vim.keymap.set('n', 'g]T', function() require("trouble").last({ skip_groups = true, jump = true }) end,
	{ desc = "Last Trouble Item" })
vim.keymap.set('n', 'g[T', function() require("trouble").first({ skip_groups = true, jump = true }) end,
	{ desc = "First Trouble Item" })

-- TODOs
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous comment" })

vim.keymap.set("n", "]e", function()
	require("todo-comments").jump_next({ keywords = { "TODO", "FIX" } })
end, { desc = "Next task" })

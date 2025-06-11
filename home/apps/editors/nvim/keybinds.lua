-- Key mappings
local builtin = require('telescope.builtin')

-- Leaders
vim.g.mapleader = ' '      -- Leader
vim.g.maplocalleader = ' ' -- Local leader

-- General
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>', { noremap = true, silent = true, desc = 'Toggle line numbers' })
vim.keymap.set('n', '<Leader>y', ':%y+<CR>', { noremap = true, silent = true, desc = 'Copy entire buffer to clip' })
vim.keymap.set('n', '<Leader>d', ':%d+<CR>', { noremap = true, silent = true, desc = 'Delete entire buffer' })

-- Comment.nvim (Commenting)
vim.keymap.set('v', '<Leader>c', ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ noremap = true, silent = true, desc = 'Toggle comment for visual' })
vim.keymap.set('n', '<Leader>c', ":lua require('Comment.api').toggle.linewise.current()<CR>",
	{ noremap = true, silent = true, desc = 'Toggle comment for current' })

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

-- Smart indent function that works in both modes
local function smart_indent()
	local mode = vim.fn.mode()
	if mode == 'v' or mode == 'V' or mode == '\22' then
		-- Visual mode: indent and keep selection
		vim.cmd('normal! >gv')
	else
		-- Normal mode: indent current line
		vim.cmd('normal! >>')
	end
end

-- Smart outdent function that works in both modes
local function smart_outdent()
	local mode = vim.fn.mode()
	if mode == 'v' or mode == 'V' or mode == '\22' then
		-- Visual mode: outdent and keep selection
		vim.cmd('normal! <gv')
	else
		-- Normal mode: outdent current line
		vim.cmd('normal! <<')
	end
end

-- Key mappings
vim.keymap.set({ 'n', 'v' }, '<Leader>ii', smart_indent, {
	noremap = true,
	silent = true,
	desc = 'Smart indent line/selection'
})

vim.keymap.set({ 'n', 'v' }, '<Leader>io', smart_outdent, {
	noremap = true,
	silent = true,
	desc = 'Smart outdent line/selection'
})

-- Indent Lines (Add lines to indents)
vim.keymap.set('n', '<Leader>il', '<cmd>IBLToggle<cr>', { noremap = true, silent = true, desc = 'Toggle indent lines' })

-- Core file operations
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function()
	require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = 'Live grep with args' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
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
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = 'Color schemes' })

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

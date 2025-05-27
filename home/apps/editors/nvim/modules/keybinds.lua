--------------------------------------------
-- General
--------------------------------------------

-- Disable search highlight on pressing <Leader><space>
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })

-- Toggle line numbers with <Leader>n
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>', { noremap = true, silent = true, desc = 'Toggle line numbers' })

--------------------------------------------
-- Plugin-Specific
--------------------------------------------

-- Telescope (fzf)
--------------------------------------------

-- Open file finder with <Leader>ff
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = 'Find files' })

-- Search text within project with <Leader>fg
vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = 'Grep text in project' })

-- List buffers with <Leader>fb
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = 'List open buffers' })

-- Help tags with <Leader>fh
vim.keymap.set('n', '<Leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true, desc = 'Help tags' })

-- Diagnostics
--------------------------------------------

-- Go to previous diagnostic with [d
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Go to previous diagnostic' })

-- Go to next diagnostic with ]d
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Go to next diagnostic' })

-- Show hover information with <Leader>k
vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'Show hover information' })

-- Format code with <Leader>f
vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code' })

-- Rename symbol with <Leader>r
vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'Rename symbol' })

-- Comment.nvim (Commenting)
--------------------------------------------

-- Toggle comment for the selected lines (Visual mode)
vim.keymap.set('v', '<Leader>c', ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, desc = 'Toggle comment' })

-- Toggle comment for the current line (Normal mode)
vim.keymap.set('n', '<Leader>c', ":lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, desc = 'Toggle comment' })

-- VimTeX (LaTeX Editing)
--------------------------------------------

-- Use <space> as leader based on vim.g.mapleader = ' '

-- -- Compile the document (starts continuous compilation if configured)
-- vim.keymap.set('n', '<Leader>ll', '<Plug>(vimtex-compile)', { noremap = true, silent = true, desc = "VimTeX Compile" })
--
-- -- View the compiled PDF (opens Zathura)
-- vim.keymap.set('n', '<Leader>lv', '<Plug>(vimtex-view)', { noremap = true, silent = true, desc = "VimTeX View PDF" })
--
-- -- Perform forward SyncTeX search (jump from code to PDF position)
-- vim.keymap.set('n', '<Leader>ls', '<Plug>(vimtex-synctex-forward)', { noremap = true, silent = true, desc = "VimTeX SyncTeX Forward" })
--
-- -- Clean auxiliary files (latexmk -C)
-- vim.keymap.set('n', '<Leader>lc', '<Plug>(vimtex-clean)', { noremap = true, silent = true, desc = "VimTeX Clean Aux Files" })
--
-- -- Clean auxiliary files thoroughly (including PDF) (latexmk -c)
-- vim.keymap.set('n', '<Leader>lC', '<Plug>(vimtex-clean-full)', { noremap = true, silent = true, desc = "VimTeX Clean Full (incl. PDF)" })
--
-- -- Show the compilation output/log
-- vim.keymap.set('n', '<Leader>lo', '<Plug>(vimtex-compile-output)', { noremap = true, silent = true, desc = "VimTeX Show Output" })
--
-- -- Show VimTeX status information
-- vim.keymap.set('n', '<Leader>lg', '<Plug>(vimtex-status)', { noremap = true, silent = true, desc = "VimTeX Status" })
--
-- -- Toggle the Table of Contents window
-- vim.keymap.set('n', '<Leader>lt', '<Plug>(vimtex-toc-toggle)', { noremap = true, silent = true, desc = "VimTeX Toggle TOC" })
--
-- -- Show compilation errors in a quickfix list
-- vim.keymap.set('n', '<Leader>le', '<Plug>(vimtex-errors)', { noremap = true, silent = true, desc = "VimTeX Show Errors" })


-- Multicursors.nvim (Multiple cursors)
--------------------------------------------

-- Start multicursor with <Leader>m
-- vim.keymap.set('n', '<Leader>m', '<cmd>MCstart<cr>', { noremap = true, silent = true, desc = 'Create a selection for selected text or word under the cursor' })


-- Treesitter (Syntax highlighting)
--------------------------------------------

-- Toggle Treesitter folding with <Leader>z
vim.keymap.set('n', '<Leader>z', ':set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()<CR>', { noremap = true, silent = true, desc = 'Toggle Treesitter folding' })


-- LuaSnip (Snippets)
--------------------------------------------

-- Expand or jump to next snippet with <Tab>
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })

-- Jump to previous snippet with <S-Tab>
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })


-- Indent Lines (Add lines to indents)
--------------------------------------------

-- Toggle indent lines with <Leader>i
vim.keymap.set('n', '<Leader>i', ':IBLToggle<CR>', { noremap = true, silent = true, desc = 'Toggle indent lines' })

-- Leaders
vim.g.mapleader = ' ' -- Leader
vim.g.maplocalleader = ' ' -- Local leader

-- General
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>', { noremap = true, silent = true, desc = 'Toggle line numbers' })
vim.keymap.set('n', '<Leader>y', ':%y+<CR>', { noremap = true, silent = true, desc = 'Copy entire buffer to clip' })
vim.keymap.set('n', '<Leader>d', ':%d+<CR>', { noremap = true, silent = true, desc = 'Delete entire buffer' })

-- Telescope (fzf)
-- vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = 'Find files' })
-- vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = 'Grep text in project' })
-- vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = 'List open buffers' })
-- vim.keymap.set('n', '<Leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true, desc = 'Help tags' })

-- Diagnostics
vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'Show hover information' })
vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code' })
vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'Rename symbol' })

-- Comment.nvim (Commenting)
vim.keymap.set('v', '<Leader>c', ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, desc = 'Toggle comment for visual' })
vim.keymap.set('n', '<Leader>c', ":lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, desc = 'Toggle comment for current' })

-- VimTeX (LaTeX Editing)
vim.keymap.set('n', '<Leader>ll', '<Plug>(vimtex-compile)', { noremap = true, silent = true, desc = "VimTeX continuous compile" })
vim.keymap.set('n', '<Leader>lv', '<Plug>(vimtex-view)', { noremap = true, silent = true, desc = "VimTeX View PDF" })
vim.keymap.set('n', '<Leader>lt', '<Plug>(vimtex-toc-toggle)', { noremap = true, silent = true, desc = "VimTeX Toggle TOC" })

-- Multicursors.nvim (Multiple cursors)
-- vim.keymap.set('n', '<Leader>m', '<cmd>MCstart<cr>', { noremap = true, silent = true, desc = 'Create a selection for selected text or word under the cursor' })

-- Treesitter (Syntax highlighting)
vim.keymap.set('n', '<Leader>z', ':set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()<CR>', { noremap = true, silent = true, desc = 'Toggle Treesitter folding' })

-- LuaSnip (Snippets)
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })

-- Indent Lines (Add lines to indents)
vim.keymap.set('n', '<Leader>il', '<cmd>IBLToggle<cr>', { noremap = true, silent = true, desc = 'Toggle indent lines' })

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
vim.keymap.set({'n', 'v'}, '<Leader>i', smart_indent, { 
    noremap = true, 
    silent = true, 
    desc = 'Smart indent line/selection' 
})

vim.keymap.set({'n', 'v'}, '<Leader>o', smart_outdent, { 
    noremap = true, 
    silent = true, 
    desc = 'Smart outdent line/selection' 
})


vim.o.cmdheight = 0         -- Hide command line when not using
vim.o.termguicolors = true  -- 24-bit RGB colors
vim.o.foldmethod = 'marker' -- Folding
vim.o.showmatch = true      -- Matching parenthesis

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

-- Statusline
vim.o.laststatus = 3 -- Always show a single global statusline

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.tabstop = 4    -- Number of spaces for each tab
vim.o.shiftwidth = 4 -- Number of spaces when shifting text

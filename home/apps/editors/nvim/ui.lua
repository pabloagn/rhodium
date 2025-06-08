-- vim.o.winbar = " " -- Padding on top of lualine
vim.o.cmdheight = 0 -- Hide command line when not using
vim.o.termguicolors = true -- 24-bit RGB colors
vim.o.foldmethod = 'marker' -- Folding
vim.o.showmatch = true -- Matching parenthesis

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

-- Global statusline
vim.o.laststatus = 3
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

-- Set number of spaces for each tab
vim.o.tabstop = 4

-- Set number of spaces when shifting text
vim.o.shiftwidth = 4

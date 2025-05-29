-- Disable nvim intro
vim.o.shortmess:append "sI"

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Encoding
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- Mouse support
vim.o.mouse = 'a'

-- Leader
vim.g.mapleader = ' '

-- Local Leader
vim.g.maplocalleader = ' '

-- Swap
vim.o.swapfile = false

-- Updatetime
vim.o.updatetime = 300

-- Enable background buffers
vim.o.hidden = true

-- Remember N lines in history
vim.o.history = 5000

-- Faster scrolling
vim.o.lazyredraw = true

-- Max column for syntax highlight
vim.o.synmaxcol = 240

-- ms to wait for trigger an event
vim.o.updatetime = 250

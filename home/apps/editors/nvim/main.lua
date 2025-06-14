local opt = vim.opt
local diagnostic = vim.diagnostic

-- Enable filetype detection and plugins
vim.cmd('filetype plugin indent on')

-- Silence deprecation warnings
vim.deprecate = function() end

-- Diagnostics
diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.HINT] = "●",
			[vim.diagnostic.severity.INFO] = "●",
		},
	},
})

-- General
opt.clipboard = 'unnamedplus' -- Enable system clipboard
opt.showmode = false          -- We already have this on line
opt.encoding = 'utf-8'        -- Encoding
opt.fileencoding = 'utf-8'    -- File encoding
opt.mouse = 'a'               -- Enable mouse support
opt.swapfile = false          -- Disable swap
opt.updatetime = 300
opt.hidden = true             -- Enable background buffers
opt.history = 5000            -- Remember N lines in history
opt.lazyredraw = true         -- Faster scrolling
opt.synmaxcol = 240           -- Max column for syntax highlight
opt.more = false
opt.undofile = true

-- UI
opt.cmdheight = 0        -- Hide command line when not using
opt.termguicolors = true -- 24-bit RGB colors
opt.showmatch = true     -- Matching parenthesis
opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.fillchars = { eob = " " } -- Remove the trailing tilde on dashboard

-- Statusline
opt.laststatus = 3 -- Always show a single global statusline

-- Search
opt.smartcase = true
opt.ignorecase = true
opt.inccommand = "split"

-- Folding
opt.foldmethod = 'manual' -- Changed from 'marker' to 'manual' (newer preference)

-- Text wrapping
opt.wrap = true
opt.linebreak = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.expandtab = true -- Use spaces instead of tabs globally
opt.tabstop = 4      -- Number of spaces for each tab
opt.shiftwidth = 4   -- Number of spaces when shifting text

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Format options
opt.formatoptions:remove "o" -- Don't have `o` add a comment

-- Shada (session data)
opt.shada = { "'10", "<0", "s10", "h" }

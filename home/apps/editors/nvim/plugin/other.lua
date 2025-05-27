-- Lualine
require("lualine").setup({
    icons_enabled = true,
    theme = 'onedark',
})

-- Colorscheme
vim.cmd("colorscheme gruvbox")

-- Comment
require("Comment").setup()

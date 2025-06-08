-- Lualine
require("lualine").setup({
    icons_enabled = true,
    theme = 'onedark',
})

vim.cmd("colorscheme gruvbox") -- Colorscheme

require("Comment").setup() -- Comment

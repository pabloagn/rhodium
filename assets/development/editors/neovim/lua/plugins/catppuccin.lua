-----------------------------------------------------------
-- Route: /clients/native/user/dev/editors/nvim/plugin/catppuccin.lua
-- Type: Module
-- Created by: Pablo Aguirre
-----------------------------------------------------------

require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "mocha",
        dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

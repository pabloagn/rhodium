require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

-- ✅ Tell Tree-sitter to use the 'go-template' parser for Hugo template files
-- vim.treesitter.language.register("gotmpl", "gohtmltmpl")

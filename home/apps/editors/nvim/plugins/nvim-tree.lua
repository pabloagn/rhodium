vim.g.loaded_netrw = 1 -- Disable netrw at the very start of init.lua
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- Enable 24-bit colour

-- Setup
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},

	view = {
		width = 30,
	},

	renderer = {
		group_empty = true,
	},

	filters = {
		dotfiles = true,
	}
})

vim.g.loaded_netrw = 1 -- Disable netrw at the very start of init.lua
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- Enable 24-bit colour

-- Setup
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},

	view = {
		width = 40,
		side = "left",
	},

	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},

	filters = {
		dotfiles = true,
	},
})

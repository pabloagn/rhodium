require("marks").setup({
	default_mappings = false,
	-- builtin_marks = { ".", "<", ">", "^" },
	cyclic = true,
	force_write_shada = false,
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {
		"qf",
		"NvimTree",
		"toggleterm",
		"TelescopePrompt",
		"alpha",
		"netrw",
	},
	bookmark_0 = { sign = "⚑", virt_text = "" },
	bookmark_1 = { sign = "①", virt_text = "" },
	bookmark_2 = { sign = "②", virt_text = "" },
	bookmark_3 = { sign = "③", virt_text = "" },
	bookmark_4 = { sign = "④", virt_text = "" },
	bookmark_5 = { sign = "⑤", virt_text = "" },
	bookmark_6 = { sign = "⑥", virt_text = "" },
	bookmark_7 = { sign = "⑦", virt_text = "" },
	bookmark_8 = { sign = "⑧", virt_text = "" },
	bookmark_9 = { sign = "⑨", virt_text = "" },
	mappings = {},
})
vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "MarkVirtTextHL", { fg = "#83C092", italic = true })

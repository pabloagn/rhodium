vim.keymap.set("n", ";pr", ":!python %<CR>", {
	buffer = true,
	desc = "Python: Run current file",
})

vim.keymap.set("n", ";pt", ":!python -m pytest %<CR>", {
	buffer = true,
	desc = "Python: Run pytest on current file",
})

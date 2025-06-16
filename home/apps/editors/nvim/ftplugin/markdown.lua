vim.keymap.set("n", ";pe", ":!pandoc % -o %:r.pdf<CR>", {
	buffer = true,
	desc = "Markdown: Export to PDF",
})

vim.keymap.set("n", ";pv", ":!zathura %:r.pdf &<CR>", {
	buffer = true,
	desc = "Markdown: View PDF live",
})

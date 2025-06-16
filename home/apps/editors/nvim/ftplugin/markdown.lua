-- PDF export and viewing
vim.keymap.set("n", ";pe", ":!pandoc % -o %:r.pdf<CR>", {
	buffer = true,
	desc = "Markdown: Export to PDF",
})

vim.keymap.set("n", ";pv", ":!zathura %:r.pdf &<CR>", {
	buffer = true,
	desc = "Markdown: View PDF live",
})

-- Markdown preview (browser-based)
vim.keymap.set("n", ";mp", ":MarkdownPreview<CR>", {
	buffer = true,
	desc = "Markdown: Preview in browser",
})

vim.keymap.set("n", ";ms", ":MarkdownPreviewStop<CR>", {
	buffer = true,
	desc = "Markdown: Stop browser preview",
})

vim.keymap.set("n", ";mt", ":MarkdownPreviewToggle<CR>", {
	buffer = true,
	desc = "Markdown: Toggle browser preview",
})

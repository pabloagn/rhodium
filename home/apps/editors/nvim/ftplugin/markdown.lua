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
vim.keymap.set("n", ";mp", "<Plug>MarkdownPreview", {
	buffer = true,
	desc = "Markdown: Preview in browser",
})

vim.keymap.set("n", ";ms", "<Plug>MarkdownPreviewStop", {
	buffer = true,
	desc = "Markdown: Stop browser preview",
})

vim.keymap.set("n", ";mt", "<Plug>MarkdownPreviewToggle", {
	buffer = true,
	desc = "Markdown: Toggle browser preview",
})

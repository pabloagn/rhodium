-- Typst preview (browser-based)
vim.keymap.set("n", ";tp", ":TypstPreview<CR>", {
	buffer = true,
	desc = "Typst: Preview in browser",
})

vim.keymap.set("n", ";tn", ":TypstPreviewNoFollowCursor<CR>", {
	buffer = true,
	desc = "Typst: Preview in browser without cursor follow",
})

vim.keymap.set("n", ";ts", ":TypstPreviewStop<CR>", {
	buffer = true,
	desc = "Typst: Stop browser preview",
})

vim.keymap.set("n", ";mt", ":TypstPreviewToggle<CR>", {
	buffer = true,
	desc = "Typst: Toggle browser preview",
})

vim.keymap.set("n", ";mt", ":TypstPreviewUpdate<CR>", {
	buffer = true,
	desc = "Typst: Update browser preview",
})

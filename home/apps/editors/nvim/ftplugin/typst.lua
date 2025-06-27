-- Typst preview (browser-based)
-- Preview
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

vim.keymap.set("n", ";tt", ":TypstPreviewToggle<CR>", {
	buffer = true,
	desc = "Typst: Toggle browser preview",
})

vim.keymap.set("n", ";tu", ":TypstPreviewUpdate<CR>", {
	buffer = true,
	desc = "Typst: Update browser preview",
})

-- LSP Server
vim.keymap.set("n", ";tep", ":LspTinymistExportPdf<CR>", {
	buffer = true,
	desc = "Typst: Export PDF",
})

vim.keymap.set("n", ";tes", ":LspTinymistExportSvg<CR>", {
	buffer = true,
	desc = "Typst: Export SVG",
})

vim.keymap.set("n", ";ten", ":LspTinymistExportPng<CR>", {
	buffer = true,
	desc = "Typst: Export PNG",
})

vim.keymap.set("n", ";tem", ":LspTinymistExportMarkdown<CR>", {
	buffer = true,
	desc = "Typst: Export Markdown",
})

vim.keymap.set("n", ";tex", ":LspTinymistExportText<CR>", {
	buffer = true,
	desc = "Typst: Export Text",
})

vim.keymap.set("n", ";teq", ":LspTinymistExportQuery<CR>", {
	buffer = true,
	desc = "Typst: Export Query",
})

vim.keymap.set("n", ";tea", ":LspTinymistExportAnsiHighlight<CR>", {
	buffer = true,
	desc = "Typst: Export ANSI Highlight",
})

vim.keymap.set("n", ";tis", ":LspTinymistGetServerInfo<CR>", {
	buffer = true,
	desc = "Typst: Get Server Info",
})

vim.keymap.set("n", ";tid", ":LspTinymistGetDocumentTrace<CR>", {
	buffer = true,
	desc = "Typst: Get Document Trace",
})

vim.keymap.set("n", ";til", ":LspTinymistGetWorkspaceLabels<CR>", {
	buffer = true,
	desc = "Typst: Get Workspace Labels",
})

vim.keymap.set("n", ";tim", ":LspTinymistGetDocumentMetrics<CR>", {
	buffer = true,
	desc = "Typst: Get Document Metrics",
})

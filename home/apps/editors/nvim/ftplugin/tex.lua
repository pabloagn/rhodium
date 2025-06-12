-- VimTeX (LaTeX Editing)
-- -------------------------------------------------
vim.keymap.set('n', ';ll', '<Plug>(vimtex-compile)',
	{
		buffer = true,
		desc = "VimTeX: Continuous compile"
	})
vim.keymap.set('n', ';lv', '<Plug>(vimtex-view)',
	{
		buffer = true,
		desc = "VimTeX: View PDF"
	})
vim.keymap.set('n', ';lt', '<Plug>(vimtex-toc-toggle)',
	{
		buffer = true,
		desc = "VimTeX: Toggle TOC"
	})

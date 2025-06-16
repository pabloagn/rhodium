-- Basic configuration
vim.g.mkdp_auto_start = 0 -- Don't auto-start preview
vim.g.mkdp_auto_close = 1 -- Auto-close when switching buffers
vim.g.mkdp_refresh_slow = 0 -- Auto-refresh as you edit
vim.g.mkdp_command_for_global = 0 -- Only available in markdown files
vim.g.mkdp_open_to_the_world = 0 -- Only localhost access
vim.g.mkdp_open_ip = "" -- Use default IP
vim.g.mkdp_browser = "" -- Use default browser
vim.g.mkdp_echo_preview_url = 0 -- Don't echo URL
vim.g.mkdp_browserfunc = "" -- Use default browser function
vim.g.mkdp_port = "" -- Use random port
vim.g.mkdp_page_title = "「${name}」" -- Page title format
vim.g.mkdp_filetypes = { "markdown" } -- Supported filetypes
vim.g.mkdp_theme = "dark" -- Default theme (dark/light)
vim.g.mkdp_combine_preview = 0 -- Don't reuse preview windows
vim.g.mkdp_combine_preview_auto_refresh = 1 -- Auto-refresh combined preview

-- Preview options
vim.g.mkdp_preview_options = {
	mkit = {},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = 0,
	sync_scroll_type = "middle", -- middle, top, or relative
	hide_yaml_meta = 1, -- Hide YAML frontmatter
	sequence_diagrams = {},
	flowchart_diagrams = {},
	content_editable = false,
	disable_filename = 0,
	toc = {},
}


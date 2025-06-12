local M = {}

-- System Info
-- --------------------------------------------------
-- Dynamic hostname detection
function M.get_hostname()
	local handle = io.popen("hostname")
	if handle then
		local result = handle:read("*a"):gsub("%s+", "")
		handle:close()
		return result
	end
	return "your-hostname"
end

-- Dynamic username detection
function M.get_username()
	return os.getenv("USER") or "your-username"
end

-- Edits
-- --------------------------------------------------
-- Function to replace entire buffer content with clipboard content
function M.replace_buffer_with_clipboard()
	-- Check if clipboard has content
	local clipboard_content = vim.fn.getreg('+')

	if clipboard_content == '' then
		vim.notify('Clipboard is empty', vim.log.levels.WARN, { title = 'Buffer Switch' })
		return
	end

	-- Get current buffer
	local buf = vim.api.nvim_get_current_buf()

	-- Check if buffer is modifiable
	if not vim.api.nvim_buf_get_option(buf, 'modifiable') then
		vim.notify('Buffer is not modifiable', vim.log.levels.ERROR, { title = 'Buffer Switch' })
		return
	end

	-- Save current cursor position (optional, for restoration)
	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	-- Get total line count
	local line_count = vim.api.nvim_buf_line_count(buf)

	-- Replace all buffer content with clipboard content
	-- Split clipboard content into lines
	local lines = vim.split(clipboard_content, '\n', { plain = true })

	-- Replace buffer content
	vim.api.nvim_buf_set_lines(buf, 0, line_count, false, lines)

	-- Move cursor to beginning of buffer
	vim.api.nvim_win_set_cursor(0, { 1, 0 })

	-- Show confirmation message
	local line_count_new = #lines
	vim.notify(
		string.format('Buffer replaced with clipboard content (%d lines)', line_count_new),
		vim.log.levels.INFO,
		{ title = 'Buffer Switch' }
	)
end

-- Replace buffer content with specific register content
function M.replace_buffer_with_register(register)
	register = register or '+'

	-- Get register content
	local register_content = vim.fn.getreg(register)

	if register_content == '' then
		vim.notify(
			string.format('Register "%s" is empty', register),
			vim.log.levels.WARN,
			{ title = 'Buffer Switch' }
		)
		return
	end

	-- Get current buffer
	local buf = vim.api.nvim_get_current_buf()

	-- Check if buffer is modifiable
	if not vim.api.nvim_buf_get_option(buf, 'modifiable') then
		vim.notify('Buffer is not modifiable', vim.log.levels.ERROR, { title = 'Buffer Switch' })
		return
	end

	-- Get total line count
	local line_count = vim.api.nvim_buf_line_count(buf)

	-- Split register content into lines
	local lines = vim.split(register_content, '\n', { plain = true })

	-- Replace buffer content
	vim.api.nvim_buf_set_lines(buf, 0, line_count, false, lines)

	-- Move cursor to beginning of buffer
	vim.api.nvim_win_set_cursor(0, { 1, 0 })

	-- Show confirmation message
	local line_count_new = #lines
	vim.notify(
		string.format('Buffer replaced with register "%s" content (%d lines)', register, line_count_new),
		vim.log.levels.INFO,
		{ title = 'Buffer Switch' }
	)
end

-- Indents
-- --------------------------------------------------
-- Smart indent function that works in both modes
function M.smart_indent()
	local mode = vim.fn.mode()
	if mode == 'v' or mode == 'V' or mode == '\22' then
		-- Visual mode: indent and keep selection
		vim.cmd('normal! >gv')
	else
		-- Normal mode: indent current line
		vim.cmd('normal! >>')
	end
end

-- Smart outdent function that works in both modes
function M.smart_outdent()
	local mode = vim.fn.mode()
	if mode == 'v' or mode == 'V' or mode == '\22' then
		-- Visual mode: outdent and keep selection
		vim.cmd('normal! <gv')
	else
		-- Normal mode: outdent current line
		vim.cmd('normal! <<')
	end
end

-- Pickers
-- --------------------------------------------------
function M.todo_picker(opts)
	opts = opts or {}

	-- Priority keywords in order (highest to lowest priority)
	local priority_keywords = {
		"SEV1", "SEV2", "SEV3",
		"FIX", "FIXME", "BUG", "FIXIT", "ISSUE",
		"TODO",
		"HACK", "WARN", "WARNING", "XXX",
		"PERF", "IMPR", "OPTIM", "PERFORMANCE", "OPTIMIZE",
		"NOTE", "INFO",
		"TEST", "TESTING", "PASSED", "FAILED",
		"DONE"
	}

	-- Enhanced options for the picker
	local enhanced_opts = vim.tbl_deep_extend("force", {
		keywords = priority_keywords,
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.85,
			preview_width = 0.6,
		},
		sorting_strategy = "ascending",
		prompt_title = "λ ",
	}, opts)

	-- Use the built-in todo-comments telescope extension
	require('telescope').extensions.todo_comments.todo(enhanced_opts)
end

_G.functions = M -- Make functions globally available
return M -- Return functions locally as well


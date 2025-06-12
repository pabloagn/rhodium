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
-- Replace entire buffer content with clipboard content
function M.replace_buffer_with_clipboard()
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

-- Replace visual selection with clipboard content
function M.replace_selection_with_clipboard()
	-- Get clipboard contents
	local clipboard_content = vim.fn.getreg('+')
	if clipboard_content == '' then
		vim.notify('Clipboard is empty', vim.log.levels.WARN, { title = 'Selection Replace' })
		return
	end

	-- Get current buffer
	local buf = vim.api.nvim_get_current_buf()

	-- Check if buffer is modifiable
	if not vim.api.nvim_buf_get_option(buf, 'modifiable') then
		vim.notify('Buffer is not modifiable', vim.log.levels.ERROR, { title = 'Selection Replace' })
		return
	end

	-- Get visual selection range
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_row, start_col = start_pos[2] - 1, start_pos[3] - 1
	local end_row, end_col = end_pos[2] - 1, end_pos[3]

	-- Validate selection
	if start_row < 0 or end_row < 0 then
		vim.notify('Invalid visual selection', vim.log.levels.ERROR, { title = 'Selection Replace' })
		return
	end

	-- Split clipboard content into lines
	local lines = vim.split(clipboard_content, '\n', { plain = true })

	-- Handle different selection modes
	local selection_mode = vim.fn.visualmode()

	if selection_mode == 'V' then -- Line-wise visual mode
		-- Replace entire lines
		vim.api.nvim_buf_set_lines(buf, start_row, end_row + 1, false, lines)
		-- Position cursor at start of first inserted line
		vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	else -- Character-wise or block-wise visual mode
		-- For character-wise, we need to handle partial line replacement
		if start_row == end_row then
			-- Single line replacement
			local current_line = vim.api.nvim_buf_get_lines(buf, start_row, start_row + 1, false)[1]
			local before = string.sub(current_line, 1, start_col)
			local after = string.sub(current_line, end_col + 1)

			if #lines == 1 then
				-- Single line clipboard content
				local new_line = before .. lines[1] .. after
				vim.api.nvim_buf_set_lines(buf, start_row, start_row + 1, false, { new_line })
				-- Position cursor after inserted content
				vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col + #lines[1] })
			else
				-- Multi-line clipboard content
				local new_lines = { before .. lines[1] }
				for i = 2, #lines - 1 do
					table.insert(new_lines, lines[i])
				end
				table.insert(new_lines, lines[#lines] .. after)
				vim.api.nvim_buf_set_lines(buf, start_row, start_row + 1, false, new_lines)
				-- Position cursor at end of inserted content
				vim.api.nvim_win_set_cursor(0, { start_row + #lines, #lines[#lines] })
			end
		else
			-- Multi-line selection replacement
			local first_line = vim.api.nvim_buf_get_lines(buf, start_row, start_row + 1, false)[1]
			local last_line = vim.api.nvim_buf_get_lines(buf, end_row, end_row + 1, false)[1]
			local before = string.sub(first_line, 1, start_col)
			local after = string.sub(last_line, end_col + 1)

			local new_lines = { before .. lines[1] }
			for i = 2, #lines - 1 do
				table.insert(new_lines, lines[i])
			end
			table.insert(new_lines, lines[#lines] .. after)

			vim.api.nvim_buf_set_lines(buf, start_row, end_row + 1, false, new_lines)
			-- Position cursor at end of inserted content
			vim.api.nvim_win_set_cursor(0, { start_row + #lines, #lines[#lines] + #after })
		end
	end

	-- Show confirmation message
	local char_count = #clipboard_content
	local line_count = #lines
	vim.notify(
		string.format('Selection replaced with clipboard content (%d lines, %d chars)', line_count, char_count),
		vim.log.levels.INFO,
		{ title = 'Selection Replace' }
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

-- Pick from project root downwards
function M.find_project_root()
	local root_patterns = {
		-- Git
		'.git',
		-- Node.js
		'package.json',
		'node_modules',
		-- Python
		'requirements.txt',
		'pyproject.toml',
		'setup.py',
		'.venv',
		-- Rust
		'Cargo.toml',
		-- Go
		'go.mod',
		-- Java
		'pom.xml',
		'build.gradle',
		-- Generic
		'Makefile',
		'justfile',
		'.project',
		'.root',
	}

	local current_dir = vim.fn.expand('%:p:h')
	if current_dir == '' then
		current_dir = vim.fn.getcwd()
	end

	-- Search upwards from current file's directory
	local function find_root(path)
		for _, pattern in ipairs(root_patterns) do
			local full_path = path .. '/' .. pattern
			if vim.fn.isdirectory(full_path) == 1 or vim.fn.filereadable(full_path) == 1 then
				return path
			end
		end

		local parent = vim.fn.fnamemodify(path, ':h')
		if parent == path then
			-- Reached filesystem root
			return nil
		end

		return find_root(parent)
	end

	local project_root = find_root(current_dir)
	return project_root or vim.fn.getcwd() -- Fallback to current working directory
end

-- Find files in project root
function M.find_files_in_project()
	local project_root = M.find_project_root()

	if not project_root then
		vim.notify('Could not find project root', vim.log.levels.WARN, { title = 'Project Files' })
		return
	end

	-- Check if Telescope is available
	local telescope_ok, telescope = pcall(require, 'telescope.builtin')
	if telescope_ok then
		-- Use Telescope if available
		telescope.find_files({
			cwd = project_root,
			prompt_title = 'Project Files (' .. vim.fn.fnamemodify(project_root, ':t') .. ')'
		})
	else
		-- Fallback to built-in file finder
		vim.cmd('cd ' .. project_root)
		vim.cmd('edit .')
		vim.notify('Changed directory to project root: ' .. project_root, vim.log.levels.INFO,
			{ title = 'Project Files' })
	end
end

-- Comments
-- --------------------------------------------------
function CommentAppend()
	local api = require('Comment.api')
	local line = vim.api.nvim_get_current_line()

	-- If already commented, just move to end of comment symbol
	if line:match("^%s*//") or line:match("^%s*#") or line:match("^%s*--") then
		-- Move to end of comment symbol
		local _, finish = line:find("^%s*[%/%-%#]+%s*")
		if finish then
			vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], finish })
			vim.cmd("startinsert")
		end
	else
		-- Comment the line
		api.toggle.linewise.current()
		-- Get updated line and move to end of comment symbol
		local new_line = vim.api.nvim_get_current_line()
		local _, finish = new_line:find("^%s*[%/%-%#]+%s*")
		if finish then
			vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], finish })
			vim.cmd("startinsert")
		end
	end
end

-- Diagnostics
-- --------------------------------------------------
-- Toggle native virtual text diagnostics
local virtual_text_enabled = true
function M.toggle_virtual_text()
	virtual_text_enabled = not virtual_text_enabled

	vim.diagnostic.config({
		virtual_text = virtual_text_enabled and {
			enabled = true,
			source = "if_many",
			prefix = "●",
			format = function(diagnostic)
				local severity = vim.diagnostic.severity[diagnostic.severity]
				local source = diagnostic.source and string.format("[%s]", diagnostic.source) or ""
				return string.format("%s %s %s", severity:sub(1, 1), source, diagnostic.message)
			end,
			spacing = 2,
		} or false
	})

	vim.notify("Virtual text: " .. (virtual_text_enabled and "enabled" or "disabled"),
		vim.log.levels.INFO, { title = "Diagnostics" })
end

-- Toggle tiny-inline-diagnostic
function M.toggle_inline_diagnostics()
	local tiny = require("tiny-inline-diagnostic")

	if M.is_tiny_diagnostic_enabled() then
		tiny.disable()
		vim.notify("Inline diagnostics disabled", vim.log.levels.INFO, { title = "Diagnostics" })
	else
		tiny.enable()
		vim.notify("Inline diagnostics enabled", vim.log.levels.INFO, { title = "Diagnostics" })
	end
end

-- Check if tiny-inline-diagnostic is enabled
function M.is_tiny_diagnostic_enabled()
	local ok, tiny = pcall(require, "tiny-inline-diagnostic")
	if not ok then return false end

	-- TODO: This is a simple check - you might need to adjust based on plugin's API
	return true -- Plugin doesn't expose enabled state, assume enabled if loaded
end

-- Show diagnostic popup on current line
function M.show_line_diagnostics()
	vim.diagnostic.open_float(nil, {
		focus = false,
		scope = "line",
		border = "rounded",
		source = "always",
		header = "Diagnostics:",
		prefix = function(diagnostic, i, total)
			local severity = vim.diagnostic.severity[diagnostic.severity]
			local icon = severity == "ERROR" and "  " or
				severity == "WARN" and "  " or
				severity == "INFO" and "  " or "  "
			return string.format("%d/%d %s", i, total, icon)
		end,
	})
end

-- Show all buffer diagnostics
function M.show_buffer_diagnostics()
	vim.diagnostic.open_float(nil, {
		focus = true,
		scope = "buffer",
		border = "rounded",
		source = "always",
		header = "Buffer Diagnostics:",
	})
end

-- Jump to next/previous diagnostic with notification
function M.goto_next_diagnostic()
	vim.diagnostic.goto_next({
		severity = { min = vim.diagnostic.severity.HINT },
		float = { border = "rounded" }
	})
	M.show_current_diagnostic()
end

function M.goto_prev_diagnostic()
	vim.diagnostic.goto_prev({
		severity = { min = vim.diagnostic.severity.HINT },
		float = { border = "rounded" }
	})
	M.show_current_diagnostic()
end

-- Show diagnostic at cursor position
function M.show_current_diagnostic()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })

	if #diagnostics > 0 then
		local diagnostic = diagnostics[1]
		local severity = vim.diagnostic.severity[diagnostic.severity]
		local message = string.format("[%s] %s", severity, diagnostic.message)
		vim.notify(message, vim.log.levels.INFO, { title = "Diagnostic" })
	end
end

-- Change diagnostic severity filter for tiny-inline-diagnostic
function M.set_diagnostic_severity(severities)
	local ok, tiny = pcall(require, "tiny-inline-diagnostic")
	if not ok then
		vim.notify("tiny-inline-diagnostic not available", vim.log.levels.WARN)
		return
	end

	tiny.change_severities(severities)
	local severity_names = {}
	for _, sev in ipairs(severities) do
		table.insert(severity_names, vim.diagnostic.severity[sev])
	end

	vim.notify("Showing severities: " .. table.concat(severity_names, ", "),
		vim.log.levels.INFO, { title = "Diagnostics" })
end

-- Preset severity filters
function M.show_errors_only()
	M.set_diagnostic_severity({ vim.diagnostic.severity.ERROR })
end

function M.show_errors_and_warnings()
	M.set_diagnostic_severity({ vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN })
end

function M.show_all_diagnostics()
	M.set_diagnostic_severity({
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.INFO,
		vim.diagnostic.severity.HINT
	})
end

-- Cursors
-- --------------------------------------------------
-- Smart pattern selection - prompts for pattern and selects matches
function M.smart_pattern_select()
	local pattern = vim.fn.input("Pattern: ")
	if pattern == "" then
		vim.notify("No pattern entered", vim.log.levels.WARN, { title = "Multicursor" })
		return
	end

	vim.cmd("MCpattern")
	vim.notify(string.format("Selected pattern: %s", pattern), vim.log.levels.INFO, { title = "Multicursor" })
end

-- Create cursors from visual selection with pattern
function M.visual_pattern_select()
	-- Check if we're in visual mode
	local mode = vim.fn.mode()
	if not (mode == 'v' or mode == 'V' or mode == '\22') then
		vim.notify("Must be in visual mode", vim.log.levels.WARN, { title = "Multicursor" })
		return
	end

	local pattern = vim.fn.input("Pattern within selection: ")
	if pattern == "" then
		vim.notify("No pattern entered", vim.log.levels.WARN, { title = "Multicursor" })
		return
	end

	vim.cmd("MCvisualPattern")
	vim.notify(string.format("Selected pattern in visual: %s", pattern), vim.log.levels.INFO, { title = "Multicursor" })
end

-- Toggle multicursor on word under cursor
function M.toggle_word_cursor()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		vim.notify("No word under cursor", vim.log.levels.WARN, { title = "Multicursor" })
		return
	end

	vim.cmd("MCunderCursor")
	vim.notify(string.format("Multicursor on: %s", word), vim.log.levels.INFO, { title = "Multicursor" })
end

-- Start multicursor on current selection or word
function M.start_multicursor()
	local mode = vim.fn.mode()

	if mode == 'v' or mode == 'V' or mode == '\22' then
		-- Visual mode - use visual selection
		vim.cmd("MCvisual")
		vim.notify("Multicursor started on visual selection", vim.log.levels.INFO, { title = "Multicursor" })
	else
		-- Normal mode - use word under cursor
		local word = vim.fn.expand("<cword>")
		if word == "" then
			vim.notify("No word under cursor", vim.log.levels.WARN, { title = "Multicursor" })
			return
		end
		vim.cmd("MCstart")
		vim.notify(string.format("Multicursor started on: %s", word), vim.log.levels.INFO, { title = "Multicursor" })
	end
end

-- Clear all multicursors
function M.clear_multicursors()
	vim.cmd("MCclear")
	vim.notify("Multicursors cleared", vim.log.levels.INFO, { title = "Multicursor" })
end

-- Get multicursor status for statusline
function M.get_multicursor_status()
	local ok, hydra = pcall(require, 'hydra.statusline')
	if ok and hydra.is_active() then
		return hydra.get_name()
	end
	return ""
end

-- Check if multicursor is active
function M.is_multicursor_active()
	local ok, hydra = pcall(require, 'hydra.statusline')
	return ok and hydra.is_active()
end

-- Exposure
-- --------------------------------------------------
-- Make it available both ways
_G.functions = M
package.loaded['functions'] = M

return M

local dirs = {
	academic = vim.fn.expand("$HOME/academic"),
	professional = vim.fn.expand("$HOME/professional"),
	projects = vim.fn.expand("$HOME/dev"),
	solenoidlabs = vim.fn.expand("$HOME/solenoid-labs"),
	vaults = vim.fn.expand("$HOME/vaults"),
	rhodium = vim.fn.expand("$HOME/dev/rhodium"),
}

-- Helper Functions
local function get_logo()
	local logo = [[
  ╦═══╗┬   ┬┌───┐ ┌┬─┐┬┬   ┬┌─┬─┐
  ║   ║│   ││   │  │ │││   ││ │ │
  ╠═╦═╝├───┤│   │  │ │││   ││ │ │
  ║ ║  │   ││   │  │ │││   ││ │ │
  ╩ ╚══┴   ┴└───┘──┴─┘┴└───┘┴   ┴
]]
	logo = string.rep("\n", 8) .. logo .. "\n\n"
	return vim.split(logo, "\n")
end

local function get_footer()
	return { "────────────── ‡ ──────────────" }
end

local function touch_file()
	-- Create new file
	vim.cmd("enew")
	vim.bo.buftype = ""
	vim.bo.bufhidden = "wipe"
	print("New file created. Use :w <path> to save or :q! to discard")
end

local function make_directory()
	-- Create new dir
	vim.ui.input({ prompt = "Directory path: " }, function(input)
		if input and input ~= "" then
			local path = vim.fn.expand(input)
			vim.fn.mkdir(path, "p")
			print("Created directory: " .. path)
		end
	end)
end

local function make_project()
	-- Create new project
	vim.ui.input({ prompt = "Project path: " }, function(input)
		if input and input ~= "" then
			local path = vim.fn.expand(input)
			vim.fn.mkdir(path, "p")
			-- Change to the new directory
			vim.cmd("cd " .. path)
			-- Initialize git if desired
			vim.ui.select({ "Yes", "No" }, {
				prompt = "Initialize git repository?",
			}, function(choice)
				if choice == "Yes" then
					vim.fn.system("git init " .. path)
					print("Created project with git at: " .. path)
				else
					print("Created project at: " .. path)
				end
			end)
		end
	end)
end

local function quick_note()
	-- Helper function for quick note
	local notes_dir = vim.fn.expand("$HOME/notes")
	vim.fn.mkdir(notes_dir, "p")
	local timestamp = os.date("%Y%m%d_%H%M%S")
	local filename = notes_dir .. "/quick_note_" .. timestamp .. ".md"
	vim.cmd("edit " .. filename)
	-- Add a timestamp header
	vim.api.nvim_buf_set_lines(0, 0, 0, false, {
		"# Quick Note - " .. os.date("%Y-%m-%d %H:%M:%S"),
		"",
		"",
	})
	-- Move cursor to line 3
	vim.cmd("normal! 3G")
end

-- Navigation with history support
local function navigate_with_history(base_dir, title)
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local history = { base_dir }
	local current_index = 1

	local function update_prompt(picker)
		local current_path = history[current_index]
		local relative_path = current_path:gsub("^" .. vim.fn.expand("$HOME"), "~")
		picker.prompt_title = title .. " [" .. relative_path .. "]"
		picker:refresh()
	end

	local function navigate()
		builtin.find_files({
			prompt_title = title,
			cwd = history[current_index],
			attach_mappings = function(prompt_bufnr, map)
				-- Navigate into directory
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					if selection then
						local path = history[current_index] .. "/" .. selection[1]
						if vim.fn.isdirectory(path) == 1 then
							-- Add to history and navigate
							if current_index < #history then
								-- Remove forward history
								for i = #history, current_index + 1, -1 do
									table.remove(history, i)
								end
							end
							table.insert(history, path)
							current_index = #history
							actions.close(prompt_bufnr)
							navigate()
						else
							-- Open file
							actions.close(prompt_bufnr)
							vim.cmd("edit " .. path)
						end
					end
				end)

				-- Go back with <C-h> or <BS>
				map("i", "<C-h>", function()
					if current_index > 1 then
						current_index = current_index - 1
						actions.close(prompt_bufnr)
						navigate()
					end
				end)

				map("i", "<BS>", function()
					if current_index > 1 then
						current_index = current_index - 1
						actions.close(prompt_bufnr)
						navigate()
					end
				end)

				-- Go forward with <C-l>
				map("i", "<C-l>", function()
					if current_index < #history then
						current_index = current_index + 1
						actions.close(prompt_bufnr)
						navigate()
					end
				end)

				-- Update prompt to show current path
				update_prompt(action_state.get_current_picker(prompt_bufnr))

				return true
			end,
		})
	end

	navigate()
end

-- Ensure dashboard stays open
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	callback = function()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		local non_dashboard_buffers = vim.tbl_filter(function(buf)
			return vim.bo[buf.bufnr].filetype ~= "dashboard"
		end, buffers)

		-- If only dashboard remains or no buffers, show dashboard
		if #non_dashboard_buffers == 0 then
			vim.defer_fn(function()
				-- Check if we're in a terminal that auto-closes
				if vim.fn.exists("$NVIM_LISTEN_ADDRESS") == 1 or vim.fn.exists("$NVIM") == 1 then
					require("dashboard"):open()
				end
			end, 50)
		end
	end,
})

-- Custom keybindings for dashboard
vim.api.nvim_create_autocmd("FileType", {
	pattern = "dashboard",
	callback = function()
		-- Quit with q
		vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })

		-- Disable search
		vim.keymap.set("n", "/", "<Nop>", { buffer = true, silent = true })

		-- File operations
		vim.keymap.set("n", "ft", touch_file, { buffer = true, silent = true, desc = "Touch File" })
		vim.keymap.set("n", "fn", quick_note, { buffer = true, silent = true, desc = "Quick Note" })
		vim.keymap.set("n", "fd", make_directory, { buffer = true, silent = true, desc = "Make Directory" })
		vim.keymap.set("n", "fp", make_project, { buffer = true, silent = true, desc = "Make Project" })

		vim.keymap.set("n", "fr", function()
			require("telescope.builtin").find_files({
				prompt_title = "Rhodium",
				cwd = dirs.rhodium,
			})
		end, { buffer = true, silent = true, desc = "Files Rhodium" })

		vim.keymap.set("n", "fR", function()
			require("telescope").extensions.frecency.frecency({
				prompt_title = "Recent Files",
			})
		end, { buffer = true, silent = true, desc = "Files Recent" })

		vim.keymap.set("n", "fa", function()
			require("telescope.builtin").find_files({
				prompt_title = "All Files",
				hidden = true,
				no_ignore = true,
			})
		end, { buffer = true, silent = true, desc = "Files All" })

		-- Z mappings with navigation history
		vim.keymap.set("n", "za", function()
			navigate_with_history(dirs.academic, "Academic")
		end, { buffer = true, silent = true, desc = "Z Academic" })

		vim.keymap.set("n", "zw", function()
			navigate_with_history(dirs.professional, "Professional")
		end, { buffer = true, silent = true, desc = "Z Professional (Work)" })

		vim.keymap.set("n", "zp", function()
			navigate_with_history(dirs.projects, "Projects")
		end, { buffer = true, silent = true, desc = "Z Project" })

		vim.keymap.set("n", "zs", function()
			navigate_with_history(dirs.solenoidlabs, "Solenoid Labs")
		end, { buffer = true, silent = true, desc = "Z Solenoid Labs" })

		vim.keymap.set("n", "zv", function()
			navigate_with_history(dirs.vaults, "Vaults")
		end, { buffer = true, silent = true, desc = "Z Vault" })

		-- Health check
		vim.keymap.set("n", "hc", ":checkhealth<CR>", { buffer = true, silent = true, desc = "Health Check" })

		-- Help with ?
		vim.keymap.set("n", "?", function()
			local keybindings = {
				"File Operations:",
				"  [ft] Touch File       - Create new file",
				"  [fn] Quick Note       - Create timestamped note",
				"  [fd] Make Directory   - Create new directory",
				"  [fp] Make Project     - Create project with optional git",
				"  [fr] Files Rhodium    - Find files in ~/dev/rhodium",
				"  [fR] Files Recent     - Recent files (frecency)",
				"  [fa] Files All        - Find all files (includes hidden/ignored)",
				"",
				"Navigation (use <C-h>/<BS> to go back, <C-l> forward):",
				"  [za] Z Academic       - Navigate academic projects",
				"  [zw] Z Professional   - Navigate professional/work projects",
				"  [zp] Z Project        - Navigate personal projects",
				"  [zs] Z Solenoid Labs  - Navigate Solenoid Labs projects",
				"  [zv] Z Vault          - Navigate vaults",
				"",
				"Other:",
				"  [hc] Health Check     - Run :checkhealth",
				"  [q]  Quit             - Exit Neovim",
				"  [?]  Help             - Show this menu",
			}

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Dashboard Shortcuts",
					finder = require("telescope.finders").new_table({
						results = keybindings,
					}),
					sorter = require("telescope.config").values.generic_sorter({}),
					layout_config = {
						width = 0.7,
						height = 0.6,
					},
				})
				:find()
		end, { buffer = true, silent = true, desc = "Show dashboard keybindings" })
	end,
})

require("dashboard").setup({
	theme = "doom",
	hide = {
		statusline = false,
		tabline = true,
		winbar = true,
	},
	config = {
		header = get_logo(),
		center = {
			{
				action = touch_file,
				desc = " Touch File",
				icon = "⊹ ",
				key = "ft",
			},
			{
				action = quick_note,
				desc = " Quick Note",
				icon = "⊹ ",
				key = "fn",
			},
			{
				action = make_directory,
				desc = " Make Directory",
				icon = "⊹ ",
				key = "fd",
			},
			{
				action = make_project,
				desc = " Make Project",
				icon = "⊹ ",
				key = "fp",
			},
			{
				action = function()
					require("telescope.builtin").find_files({
						prompt_title = "Rhodium",
						cwd = dirs.rhodium,
					})
				end,
				desc = " Files Rhodium",
				icon = "⊹ ",
				key = "fr",
			},
			{
				action = function()
					require("telescope").extensions.frecency.frecency({
						prompt_title = "Recent Files",
					})
				end,
				desc = " Files Recent",
				icon = "⊹ ",
				key = "fR",
			},
			{
				action = function()
					require("telescope.builtin").find_files({
						prompt_title = "All Files",
						hidden = true,
						no_ignore = true,
					})
				end,
				desc = " Files All",
				icon = "⊹ ",
				key = "fa",
			},
			{
				action = function()
					navigate_with_history(dirs.academic, "Academic")
				end,
				desc = " Z Academic",
				icon = "⊹ ",
				key = "za",
			},
			{
				action = function()
					navigate_with_history(dirs.professional, "Professional")
				end,
				desc = " Z Professional",
				icon = "⊹ ",
				key = "zw",
			},
			{
				action = function()
					navigate_with_history(dirs.projects, "Projects")
				end,
				desc = " Z Project",
				icon = "⊹ ",
				key = "zp",
			},
			{
				action = function()
					navigate_with_history(dirs.solenoidlabs, "Solenoid Labs")
				end,
				desc = " Z Solenoid Labs",
				icon = "⊹ ",
				key = "zs",
			},
			{
				action = function()
					navigate_with_history(dirs.vaults, "Vaults")
				end,
				desc = " Z Vault",
				icon = "⊹ ",
				key = "zv",
			},
			{
				action = "checkhealth",
				desc = " Health Check",
				icon = "⊹ ",
				key = "hc",
			},
			{
				action = function()
					local keybindings = {
						"File Operations:",
						"  [ft] Touch File       - Create new file",
						"  [fn] Quick Note       - Create timestamped note",
						"  [fd] Make Directory   - Create new directory",
						"  [fp] Make Project     - Create project with optional git",
						"  [fr] Files Rhodium    - Find files in ~/dev/rhodium",
						"  [fR] Files Recent     - Recent files (frecency)",
						"  [fa] Files All        - Find all files (includes hidden/ignored)",
						"",
						"Navigation (use <C-h>/<BS> to go back, <C-l> forward):",
						"  [za] Z Academic       - Navigate academic projects",
						"  [zw] Z Professional   - Navigate professional/work projects",
						"  [zp] Z Project        - Navigate personal projects",
						"  [zs] Z Solenoid Labs  - Navigate Solenoid Labs projects",
						"  [zv] Z Vault          - Navigate vaults",
						"",
						"Other:",
						"  [hc] Health Check     - Run :checkhealth",
						"  [q]  Quit             - Exit Neovim",
						"  [?]  Help             - Show this menu",
					}

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Dashboard Shortcuts",
							finder = require("telescope.finders").new_table({
								results = keybindings,
							}),
							sorter = require("telescope.config").values.generic_sorter({}),
							layout_config = {
								width = 0.7,
								height = 0.6,
							},
						})
						:find()
				end,
				desc = " Shortcut Help",
				icon = "⊹ ",
				key = "?",
			},
		},
		footer = get_footer(),
	},
})

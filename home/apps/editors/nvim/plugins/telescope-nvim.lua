-- require('telescope').setup({
-- 	defaults = {
-- 		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
-- 	},
-- 	extensions = {
-- 		fzf = {
-- 			fuzzy = true,
-- 			override_generic_sorter = true,
-- 			override_file_sorter = true,
-- 			case_mode = "smart_case",
-- 		}
-- 	}
-- })
--
-- require('telescope').load_extension('fzf')

local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

telescope.setup({
    defaults = {
        -- Transparency and blur effects
        winblend = 15,
        pumblend = 15,

        -- Prompt styling
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "   ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

        -- Color and visual enhancements
        color_devicons = true,
        use_less = true,
        path_display = { "smart" },
        
        -- Layout
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.90,
            height = 0.85,
            preview_cutoff = 120,
            prompt_position = "top",
            horizontal = {
                preview_width = function(_, cols, _)
                    return math.floor(cols * 0.4)
                end,
            },
            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },
            flex = {
                horizontal = {
                    preview_width = 0.9,
                },
            },
        },
        
        -- Sorting and selection strategy
        sorting_strategy = "ascending",
        selection_strategy = "reset",
        scroll_strategy = "cycle",
        
        -- Preview configuration
        preview = {
            filesize_limit = 25,
            timeout = 250,
            treesitter = true,
        },
        
        -- Advanced file filtering
        file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.npm/",
            "__pycache__/",
            "%.pyc",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip"
        },
        
        -- Mappings
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-/>"] = action_layout.toggle_preview,
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["?"] = actions.which_key,
                ["<C-/>"] = action_layout.toggle_preview,
            },
        },
        
        -- Search configuration
        vimgrep_arguments = {
            "rga",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
        },
    },
    
    -- Picker-specific configurations
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
            layout_config = {
                height = 0.70,
            },
        },

        live_grep = {
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                },
            },
        },

        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            layout_config = {
                width = 0.7,
                height = 0.4,
            },
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer,
                },
                n = {
                    ["dd"] = actions.delete_buffer,
                },
            },
        },

        git_files = {
            layout_config = {
                height = 0.70,
            },
        },

        help_tags = {
            layout_config = {
                width = 0.87,
                height = 0.80,
            },
        },

        man_pages = {
            layout_config = {
                width = 0.87,
                height = 0.80,
            },
        },

        lsp_references = {
            layout_config = {
                width = 0.87,
                height = 0.80,
            },
        },

        diagnostics = {
            layout_config = {
                width = 0.87,
                height = 0.80,
            },
        },
    },
    
    -- Extensions
    extensions = {
        -- Enhanced FZF native sorting
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        
        -- Live Grep Args
        live_grep_args = {
            auto_quoting = true,
            mappings = {
                i = {
                    ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
                },
            },
        },
        
        -- Smart file prioritization based on usage
        frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            disable_devicons = false,
            workspaces = {
                ["conf"] = "~/.config",
                ["data"] = "~/.local/share",
                ["project"] = "~/dev",
                ["wiki"] = "~/wiki"
            }
        },
    },
})

-- Load all extensions
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')
telescope.load_extension('frecency')

-- Key mappings
local builtin = require('telescope.builtin')

-- Core file operations
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = 'Live grep with args' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
vim.keymap.set('n', '<leader>fr', function()
    require('telescope').extensions.frecency.frecency()
end, { desc = 'Recent files (frecency)' })

-- Advanced search
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = 'Search history' })

-- Git integration
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

-- LSP integration
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP implementations' })
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })

-- Advanced pickers
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Vim options' })
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = 'Color schemes' })

-- Diagnostics
vim.keymap.set('n', '<leader>xx', builtin.diagnostics, { desc = 'Diagnostics' })

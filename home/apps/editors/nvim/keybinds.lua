local functions = require('functions')
local builtin = require('telescope.builtin')

-- Leaders
-- -------------------------------------------------
vim.g.mapleader = ' '      -- Leader
vim.g.maplocalleader = ' ' -- Local leader

-- General
-- -------------------------------------------------
vim.keymap.set('n', '<Leader><space>', ':noh<CR>',
  { noremap = true, silent = true, desc = 'Base: Clear search highlight' })
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>',
  { noremap = true, silent = true, desc = 'Base: Toggle line numbers' })
vim.keymap.set('n', '<Leader>y', ':%y+<CR>', { noremap = true, silent = true, desc = 'Base: Copy entire buffer to clip' })
vim.keymap.set('n', '<Leader>D', ':%d+<CR>', { noremap = true, silent = true, desc = 'Base: Delete entire buffer' })

-- Outline/Aerial Operations
-- -------------------------------------------------
-- Main outline toggles
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>",
  {
    noremap = true,
    silent = true,
    desc = "Outline: Toggle sidebar"
  })

vim.keymap.set("n", "<leader>A", "<cmd>AerialNavToggle<CR>",
  {
    noremap = true,
    silent = true,
    desc = "Outline: Toggle navigation"
  })

-- Built-in outline (alternative to Aerial)
vim.keymap.set("n", "gO", "<cmd>AerialNavOpen<CR>",
  {
    noremap = true,
    silent = true,
    desc = "Outline: Open navigation"
  })

-- Additional outline operations
vim.keymap.set("n", "<leader>af", function()
  require("aerial").toggle()
  if require("aerial").is_open() then
    require("aerial").focus()
  end
end, {
  noremap = true,
  silent = true,
  desc = "Outline: Focus sidebar"
})

vim.keymap.set("n", "<leader>ai", function()
  local aerial = require("aerial")
  local symbols = aerial.get_symbols()
  if symbols and #symbols > 0 then
    vim.notify(string.format("Found %d symbols", #symbols), vim.log.levels.INFO, { title = "Aerial" })
  else
    vim.notify("No symbols found", vim.log.levels.WARN, { title = "Aerial" })
  end
end, {
  noremap = true,
  silent = true,
  desc = "Outline: Show symbol count"
})

-- Quick symbol navigation (when aerial is open)
vim.keymap.set("n", "<leader>an", "<cmd>AerialNext<CR>",
  {
    noremap = true,
    silent = true,
    desc = "Outline: Next symbol"
  })

vim.keymap.set("n", "<leader>ap", "<cmd>AerialPrev<CR>",
  {
    noremap = true,
    silent = true,
    desc = "Outline: Previous symbol"
  })

-- Alternative: Use telescope for symbol search
vim.keymap.set("n", "<leader>as", function()
  require("telescope").extensions.aerial.aerial()
end, {
  noremap = true,
  silent = true,
  desc = "Outline: Search symbols"
})

-- Comment
-- -------------------------------------------------
vim.keymap.set('v', '<Leader>cc', ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  {
    noremap = true,
    silent = true,
    desc = 'Comment: Toggle for visual'
  })
vim.keymap.set('n', '<Leader>cc', ":lua require('Comment.api').toggle.linewise.current()<CR>",
  {
    noremap = true,
    silent = true,
    desc = 'Comment: Toggle for current'
  })
vim.keymap.set('n', '<Leader>ca', function() functions.comment_append() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: Append'
  })
vim.keymap.set('n', '<Leader>cA', function() functions.comment_all() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: Toggle all'
  })

-- TODO comment insertion (new line)
vim.keymap.set('n', '<Leader>ct', function() functions.insert_todo() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: TODO'
  })
vim.keymap.set('n', '<Leader>cf', function() functions.insert_fix() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: FIX'
  })
vim.keymap.set('n', '<Leader>cn', function() functions.insert_note() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: NOTE'
  })
vim.keymap.set('n', '<Leader>ch', function() functions.insert_hack() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: HACK'
  })
vim.keymap.set('n', '<Leader>cw', function() functions.insert_warn() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: WARN'
  })
vim.keymap.set('n', '<Leader>cp', function() functions.insert_perf() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: PERF'
  })
vim.keymap.set('n', '<Leader>ce', function() functions.insert_test() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: TEST'
  })

-- TODO utilities
vim.keymap.set('n', '<Leader>cd', function() functions.toggle_todo_done() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: Toggle TODO/DONE'
  })
vim.keymap.set('n', '<Leader>cl', function() functions.list_buffer_todos() end,
  {
    noremap = true,
    silent = true,
    desc = 'Comment: List buffer TODOs'
  })

-- Edit
-- -------------------------------------------------
vim.keymap.set('n', '<Leader>er', function() functions.replace_buffer_with_clipboard() end,
  {
    noremap = true,
    silent = true,
    desc = 'Edit: Replace buffer with clipboard'
  })
vim.keymap.set('v', '<Leader>er', ':<C-u>lua require("functions").replace_selection_with_clipboard()<CR>',
  {
    noremap = true,
    silent = true,
    desc = 'Edit: Replace selection with clipboard'
  })
-- vim.keymap.set('v', '<Leader>er', function() functions.replace_selection_with_clipboard() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = 'Edit: Replace selection with clipboard'
--   })

-- Replace (Spectre)
-- -------------------------------------------------
vim.keymap.set('n', '<leader>rf', function()
    require('spectre').open()
  end,
  {
    desc = 'Replace: Find'
  })

vim.keymap.set('v', '<leader>rf', function()
    require('spectre').open_visual()
  end,
  {
    desc = 'Replace: Find on Visual'
  })

-- LSP Actions (Direct actions that do something)
-- -------------------------------------------------
vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'LSP: Show hover' })
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'LSP: Format' })
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'LSP: Rename symbol' })
vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = 'LSP: Code actions' })

-- LSP Navigation (Go to things - quick jumps)
-- -------------------------------------------------
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'LSP: Go to definition' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP: Go to references' })
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'LSP: Go to implementation' })
vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { desc = 'LSP: Go to type definition' })

-- Find/Search (Interactive pickers and browsers)
-- -------------------------------------------------
-- Files and project
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find: Files' })
vim.keymap.set('n', '<Leader>fp', function() functions.find_files_in_project() end,
  {
    noremap = true,
    silent = true,
    desc = 'Find: Project files'
  })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find: Buffers' })
vim.keymap.set('n', '<leader>fr', function()
    require('telescope').extensions.frecency.frecency()
  end,
  { desc = 'Find: Recent (Frecency)' })

-- Text search
vim.keymap.set('n', '<leader>fg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
  end,
  { desc = 'Find: Live grep with args' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find: Word under cursor' })

-- Diagnostics browsing
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find: Diagnostics (current file)' })
vim.keymap.set('n', '<leader>fD', function() builtin.diagnostics({ bufnr = nil }) end,
  { desc = 'Find: Diagnostics (all files)' })

-- LSP symbol browsing
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Find: Symbols (document)' })
vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, { desc = 'Find: Symbols (workspace)' })

-- Vim internals
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find: Help' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find: Keymaps' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Find: Options' })
vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Find: Command history' })
vim.keymap.set('n', '<leader>fH', builtin.search_history, { desc = 'Find: Search history' })

-- Special finders
vim.keymap.set('n', '<leader>ft', function() functions.todo_picker() end,
  {
    noremap = true,
    silent = true,
    desc = 'Find: TODOs with priority sorting'
  })

-- Trouble (Visual problem browser)
-- -------------------------------------------------
-- Core trouble toggles
vim.keymap.set('n', '<leader>tt', function() require("trouble").toggle("diagnostics") end,
  { desc = "Trouble: Toggle diagnostics" })
vim.keymap.set('n', '<leader>tb', function() require("trouble").toggle("diagnostics", { filter = { buf = 0 } }) end,
  { desc = "Trouble: Buffer diagnostics" })
vim.keymap.set('n', '<leader>tq', function() require("trouble").toggle("qflist") end, { desc = "Trouble: Quickfix list" })
vim.keymap.set('n', '<leader>tl', function() require("trouble").toggle("loclist") end,
  { desc = "Trouble: Location list" })

-- LSP-related trouble views
vim.keymap.set('n', '<leader>tr', function() require("trouble").toggle("lsp_references") end,
  { desc = "Trouble: LSP references" })
vim.keymap.set('n', '<leader>td', function() require("trouble").toggle("lsp_definitions") end,
  { desc = "Trouble: LSP definitions" })
vim.keymap.set('n', '<leader>ti', function() require("trouble").toggle("lsp_implementations") end,
  { desc = "Trouble: LSP implementations" })
vim.keymap.set('n', '<leader>ts', function() require("trouble").toggle("symbols") end,
  { desc = "Trouble: Document symbols" })

-- Trouble controls
vim.keymap.set('n', '<leader>tc', function() require("trouble").close() end, { desc = "Trouble: Close all" })

-- Trouble Navigation (No leader - direct access)
-- -------------------------------------------------
vim.keymap.set('n', ']T', function() require("trouble").next({ skip_groups = true, jump = true }) end,
  { desc = "Next trouble item" })
vim.keymap.set('n', '[T', function() require("trouble").prev({ skip_groups = true, jump = true }) end,
  { desc = "Previous trouble item" })
vim.keymap.set('n', 'g]T', function() require("trouble").last({ skip_groups = true, jump = true }) end,
  { desc = "Last trouble item" })
vim.keymap.set('n', 'g[T', function() require("trouble").first({ skip_groups = true, jump = true }) end,
  { desc = "First trouble item" })

-- Diagnostics
-- -------------------------------------------------
vim.keymap.set("n", "<Leader>dv", function() functions.toggle_virtual_text() end,
  {
    noremap = true,
    silent = true,
    desc = "Diagnostics: Toggle virtual text"
  })

vim.keymap.set("n", "<Leader>dl", function() functions.show_line_diagnostics() end,
  {
    noremap = true,
    silent = true,
    desc = "Diagnostics: Show line diagnostics"
  })

vim.keymap.set("n", "<Leader>db", function() functions.show_buffer_diagnostics() end,
  {
    noremap = true,
    silent = true,
    desc = "Diagnostics: Show buffer diagnostics"
  })

vim.keymap.set("n", "]d", function() functions.goto_next_diagnostic() end,
  {
    noremap = true,
    silent = true,
    desc = "Diagnostics: Next diagnostic"
  })

vim.keymap.set("n", "[d", function() functions.goto_prev_diagnostic() end,
  {
    noremap = true,
    silent = true,
    desc = "Diagnostics: Previous diagnostic"
  })

vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, {
  noremap = true,
  silent = true,
  desc = "Diagnostics: Next error"
})

vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, {
  noremap = true,
  silent = true,
  desc = "Diagnostics: Previous error"
})

-- -- Diagnostics Inline
-- -- -------------------------------------------------
-- vim.keymap.set("n", "<Leader>dv", function() functions.toggle_virtual_text() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Toggle virtual text"
--   })
--
-- vim.keymap.set("n", "<Leader>di", function() functions.toggle_inline_diagnostics() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Toggle inline display"
--   })
--
-- -- Show diagnostic information
-- vim.keymap.set("n", "<Leader>dl", function() functions.show_line_diagnostics() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show line diagnostics"
--   })
--
-- vim.keymap.set("n", "<Leader>db", function() functions.show_buffer_diagnostics() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show buffer diagnostics"
--   })
--
-- vim.keymap.set("n", "<Leader>dc", function() functions.show_current_diagnostic() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show current diagnostic"
--   })
--
-- -- Navigate diagnostics
-- vim.keymap.set("n", "]d", function() functions.goto_next_diagnostic() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Next diagnostic"
--   })
--
-- vim.keymap.set("n", "[d", function() functions.goto_prev_diagnostic() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Previous diagnostic"
--   })
--
-- -- Quick diagnostic navigation (errors only)
-- vim.keymap.set("n", "]e", function()
--   vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end, {
--   noremap = true,
--   silent = true,
--   desc = "Diagnostics: Next error"
-- })
--
-- vim.keymap.set("n", "[e", function()
--   vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end, {
--   noremap = true,
--   silent = true,
--   desc = "Diagnostics: Previous error"
-- })
--
-- -- Severity filtering
-- vim.keymap.set("n", "<Leader>d1", function() functions.show_errors_only() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show errors only"
--   })
--
-- vim.keymap.set("n", "<Leader>d2", function() functions.show_errors_and_warnings() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show errors & warnings"
--   })
--
-- vim.keymap.set("n", "<Leader>d3", function() functions.show_all_diagnostics() end,
--   {
--     noremap = true,
--     silent = true,
--     desc = "Diagnostics: Show all severities"
--   })

-- Auto-show diagnostics on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
  callback = function()
    -- Only show if not in insert mode
    if vim.fn.mode() ~= "i" then
      vim.diagnostic.open_float(nil, {
        focus = false,
        scope = "cursor",
        border = "single",
        source = "always",
      })
    end
  end,
})

-- Idents
-- -------------------------------------------------
vim.keymap.set({ 'n', 'v' }, '<Leader>ii', function() functions.smart_indent() end,
  {
    noremap = true,
    silent = true,
    desc = 'Indent Indent: Smart indent line/selection'
  })

vim.keymap.set({ 'n', 'v' }, '<Leader>io', function() functions.smart_outdent() end,
  {
    noremap = true,
    silent = true,
    desc = 'Indent Outdent: Smart outdent line/selection'
  })

-- Treesitter
-- -------------------------------------------------
vim.keymap.set('n', '<Leader>z', ':set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()<CR>',
  {
    noremap = true,
    silent = true,
    desc = 'Toggle Treesitter folding'
  })

-- Buffers
-- -------------------------------------------------
-- Scroll buffers
vim.keymap.set('n', '<leader>s', ':BufferLineCycleNext<CR>', { desc = 'Scroll: Next buffer', silent = true })
vim.keymap.set('n', '<leader>S', ':BufferLineCyclePrev<CR>', { desc = 'Scroll: Previous buffer', silent = true })

-- Close buffers
vim.keymap.set('n', '<leader>w', ':write | bdelete<CR>', { desc = 'Buffer: Save and close', silent = true })
vim.keymap.set('n', '<leader>q', ':bdelete!<CR>', { desc = 'Buffer: Close without saving', silent = true })

-- Move buffers
vim.keymap.set('n', '<leader>bmn', ':BufferLineMoveNext<CR>', { desc = 'Move buffer next', silent = true })
vim.keymap.set('n', '<leader>bmp', ':BufferLineMovePrev<CR>', { desc = 'Move buffer prev', silent = true })

-- Go to buffer by number
vim.keymap.set('n', '<leader>b1', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Go to buffer 1', silent = true })
vim.keymap.set('n', '<leader>b2', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Go to buffer 2', silent = true })
vim.keymap.set('n', '<leader>b3', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Go to buffer 3', silent = true })
vim.keymap.set('n', '<leader>b4', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Go to buffer 4', silent = true })
vim.keymap.set('n', '<leader>b5', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Go to buffer 5', silent = true })
vim.keymap.set('n', '<leader>b6', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Go to buffer 6', silent = true })
vim.keymap.set('n', '<leader>b7', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Go to buffer 7', silent = true })
vim.keymap.set('n', '<leader>b8', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Go to buffer 8', silent = true })
vim.keymap.set('n', '<leader>b9', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Go to buffer 9', silent = true })

-- Close buffers
vim.keymap.set('n', '<leader>bcp', ':BufferLinePickClose<CR>', { desc = 'Pick buffer to close', silent = true })
vim.keymap.set('n', '<leader>bco', ':BufferLineCloseOthers<CR>', { desc = 'Close other buffers', silent = true })

-- Close buffers in direction
vim.keymap.set('n', '<leader>bcr', ':BufferLineCloseRight<CR>', { desc = 'Close buffers to right', silent = true })
vim.keymap.set('n', '<leader>bcl', ':BufferLineCloseLeft<CR>', { desc = 'Close buffers to left', silent = true })

-- Pick buffer
vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer', silent = true })

-- Pin/unpin buffer
vim.keymap.set('n', '<leader>bP', ':BufferLineTogglePin<CR>', { desc = 'Toggle pin buffer', silent = true })

-- Sort buffers
vim.keymap.set('n', '<leader>bsd', ':BufferLineSortByDirectory<CR>', { desc = 'Sort by directory', silent = true })
vim.keymap.set('n', '<leader>bse', ':BufferLineSortByExtension<CR>', { desc = 'Sort by extension', silent = true })
vim.keymap.set('n', '<leader>bst', ':BufferLineSortByTabs<CR>', { desc = 'Sort by tabs', silent = true })

-- Buffer groups
vim.keymap.set('n', '<leader>bgt', ':BufferLineGroupToggle Tests<CR>', { desc = 'Toggle test group', silent = true })
vim.keymap.set('n', '<leader>bgd', ':BufferLineGroupToggle Docs<CR>', { desc = 'Toggle docs group', silent = true })

-- Git integration
-- -------------------------------------------------
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

-- TODOs Navigation
-- -------------------------------------------------
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "]T", function()
  require("todo-comments").jump_next({ keywords = { "TODO", "FIX" } })
end, { desc = "Next task" })

-- Multicursor
-- -------------------------------------------------
-- Core multicursor operations
vim.keymap.set({ "n", "v" }, "<Leader>m", function() functions.start_multicursor() end,
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Start on word/selection"
  })

vim.keymap.set("n", "<Leader>mc", function() functions.clear_multicursors() end,
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Clear all"
  })

-- Pattern-based selection
vim.keymap.set("n", "<Leader>mp", function() functions.smart_pattern_select() end,
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Pattern in buffer"
  })

vim.keymap.set("v", "<Leader>mp", function() functions.visual_pattern_select() end,
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Pattern in selection"
  })

-- Specialized selections
vim.keymap.set("n", "<Leader>mu", function() functions.toggle_word_cursor() end,
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Character under cursor"
  })

vim.keymap.set("v", "<Leader>mv", "<cmd>MCvisual<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Start on visual selection"
  })

-- Direct commands for advanced users
vim.keymap.set("n", "<Leader>mw", "<cmd>MCstart<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: Start on word"
  })

vim.keymap.set("n", "<Leader>ma", "<cmd>MCpattern<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: All pattern matches"
  })

-- Quick access for common workflows
vim.keymap.set("v", "<Leader>ma", "<cmd>MCvisualPattern<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Multicursor: All matches in selection"
  })

-- LuaSnip (Snippets)
-- -- TODO: Add this
-- vim.keymap.set('i', '<Tab>', "lua equire('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true, expr = true, desc = 'Expand or jump to next snippet' })
-- vim.keymap.set('i', '<S-Tab>', "lua require('luasnip').jump(-1)<CR>", { noremap = true, silent = true, expr = true, desc = 'Jump to previous snippet' })

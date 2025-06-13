local wk = require("which-key")

-- ───────────────────────────────────────────────────────────────
-- Visual Elements: Unicode Symbols for Sacred Computer Aesthetic
-- ───────────────────────────────────────────────────────────────

-- Pure Unicode symbols carefully selected to avoid emojis and maintain a consistent theme.
local sym = {
    -- Core which-key display elements
    breadcrumb = "◦",    -- Small circle for path separators
    separator = "→",     -- Right arrow for general separation
    group_icon = "",     -- No specific icon for group label prefix, as per original user setting
    ellipsis = "…",      -- Horizontal ellipsis for truncation

    -- Key specific icons (standard Unicode characters for control keys, etc.)
    key = {
        Up = "↑", Down = "↓", Left = "←", Right = "→",
        C = "⌃",  -- Control key
        M = "⌥",  -- Alt/Option key
        D = "⌘",  -- Command/Super key
        S = "⇧",  -- Shift key
        CR = "⏎", -- Carriage Return (Enter)
        Esc = "⎋", -- Escape key
        ScrollWheelDown = "↓", ScrollWheelUp = "↑",
        NL = "⏎", -- Newline
        BS = "⌫", -- Backspace
        Space = "␣", -- Space symbol
        Tab = "⇥", -- Tab key
        F1 = "ƒ1", F2 = "ƒ2", F3 = "ƒ3", F4 = "ƒ4", F5 = "ƒ5", F6 = "ƒ6",
        F7 = "ƒ7", F8 = "ƒ8", F9 = "ƒ9", F10 = "ƒ10", F11 = "ƒ11", F12 = "ƒ12",
    },

    -- General action/concept icons (pure Unicode, reusable)
    arrow_next = "⇢",      -- Dotted right arrow (next item)
    arrow_prev = "⇠",      -- Dotted left arrow (previous item)
    arrow_go = "→",        -- Solid right arrow (go to/forward)
    arrow_first = "⇤",     -- Leftwards arrow to bar (start/first)
    arrow_last = "⇥",      -- Rightwards arrow to bar (end/last)

    toggle = "◚",          -- Circle segment (general toggle switch)
    close_general = "✕",   -- Multiplication X (general close/cancel)
    close_force = "⌧",     -- Eject symbol (force close)
    save = "⌭",            -- Pasteboard symbol (save/clipboard)
    copy_all = "⧉",        -- Document with square icon (copy entire file)
    delete_all = "⌦",      -- Erase to the right (delete entire content)

    numbers_toggle = "⌗",  -- Number sign/hash
    clear_search = "□",    -- Empty square (clear highlight)

    lsp_nav_point = "⟐",   -- Diamond (LSP definition/reference point)

    -- Group category icons (from user's original setup or new additions)
    group = {
        buffer = "◈",        -- Diamond with dot (Buffer group)
        comment = "◇",       -- Hollow diamond (Comment group)
        diagnostic = "◆",    -- Solid diamond (Diagnostic group)
        edit = "◉",          -- Large solid circle (Edit group)
        find = "◎",          -- Bullseye (Find group)
        git = "◐",           -- Left half black circle (Git group)
        indent = "◑",        -- Right half black circle (Indent group)
        lsp = "◒",           -- Top half black circle (LSP group)
        multicursor = "◓",   -- Bottom half black circle (Multicursor group)
        buffer_cycle = "◔",  -- Top-left black circle (Buffer Cycle group - formerly 'Switch')
        trouble = "◕",       -- Bottom-right black circle (Trouble group)
        outline = "⌸",       -- Window icon (Aerial/Outline group)
        replace = "⟳",       -- Clockwise open circle arrow (Spectre/Replace group)
        treesitter = "◱",    -- Square with upper-left black (Treesitter group)
        todo_comments = "✓", -- Check mark (primary group for TODO comments)
    },

    -- Sub-group icons for Buffer operations
    sub_group = {
        buffer_close = "⊗",  -- Circled times (Close subgroup)
        buffer_group = "⊙",  -- Circled dot (Group subgroup)
        buffer_move = "⊚",   -- Circled white bullet (Move subgroup)
        buffer_sort = "⊛",   -- Circled asterisk (Sort subgroup)
    },

    -- Specific action icons (carefully chosen pure Unicode for relevance)
    action = {
        -- General Operations
        clear_search_highlight = "□",
        toggle_line_numbers = "⌗",
        copy_entire_buffer = "⧉",
        delete_entire_buffer = "⌦",
        save_and_close = "⌭",
        force_close_buffer = "⌧",

        -- Outline (Aerial) Operations
        outline_toggle_sidebar = "⌸",
        outline_toggle_navigation = "☰", -- Three horizontal bars (menu/navigation)
        outline_open_navigation = "☰",
        outline_focus_sidebar = "⌖",     -- Focus scope/target
        outline_show_symbol_count = "Σ", -- Sigma (sum/count)
        outline_next_symbol = "⮞",       -- Heavy rightwards arrow
        outline_prev_symbol = "⮜",       -- Heavy leftwards arrow
        outline_search_symbols = "⌕",   -- Magnifying glass

        -- Comment Operations
        comment_toggle_visual = "◚",
        comment_toggle_current = "◚",
        comment_append = "∔",         -- Plus sign with dot (append)
        comment_toggle_all = "⊚",      -- Circled white bullet (toggle all)

        -- Specific Comment Tags (using Unicode where possible)
        comment_todo = "✓ TODO",     -- Check mark
        comment_fix = "✕ FIX",       -- Multiplication X
        comment_note = "✎ NOTE",     -- Pencil
        comment_hack = "☠ HACK",     -- Skull and crossbones
        comment_warn = "⚠ WARN",     -- Warning sign
        comment_perf = "⌁ PERF",     -- Lightning bolt (performance)
        comment_test = "⚛ TEST",     -- Atom symbol (testing)

        comment_toggle_todo_done = "◚",
        comment_list_buffer_todos = "≡", -- Triple horizontal bars (list)

        -- Edit Operations
        edit_replace_buffer_clipboard = "⟳",
        edit_replace_selection_clipboard = "⟳",

        -- Replace (Spectre) Operations
        replace_find = "⌕",
        replace_find_visual = "⌕",

        -- LSP Actions
        lsp_hover = "◫",      -- Square with dot (hover box)
        lsp_format = "⌶",     -- Form feed symbol (format)
        lsp_rename = "✎",     -- Pencil (rename)
        lsp_code_actions = "⎗", -- Up arrow in box (action button)

        -- Find/Search (Telescope) Operations
        find_files = "☷",          -- Triple horizontal bars (files/documents)
        find_project_files = "⎕",  -- White square containing black square (project)
        find_buffers = "⊡",        -- Square with dot in center (buffers)
        find_recent = "◷",         -- Clock (recent items)
        find_live_grep = "⌕",
        find_word_under_cursor = "◎", -- Bullseye (word under cursor)
        find_diagnostics_current = "◒",
        find_diagnostics_all = "◒",
        find_doc_symbols = "◬",    -- Triangle with dot (document symbols)
        find_workspace_symbols = "Σ", -- Sigma (workspace symbols)

        find_help_tags = "⚑",      -- Flag (help)
        find_keymaps = "⌘",        -- Command key (keymaps)
        find_options = "⚙",       -- Gear (options)
        find_command_history = "◴", -- Clock (history)
        find_search_history = "◴",
        find_todos_priority = "✓",

        -- Trouble (Visual Problem Browser) Operations
        trouble_toggle_diagnostics = "◚",
        trouble_buffer_diagnostics = "◚",
        trouble_quickfix_list = "⚏",    -- Triple vertical bars (list)
        trouble_location_list = "⚏",
        trouble_lsp_references = "⟐",
        trouble_lsp_definitions = "⟐",
        trouble_lsp_implementations = "⟐",
        trouble_document_symbols = "◬",
        trouble_close_all = "✕",

        -- Trouble Navigation (direct keys `]T`, `[T`, `g]T`, `g[T`)
        trouble_next_item = "⇢",
        trouble_prev_item = "⇠",
        trouble_last_item = "⇥",
        trouble_first_item = "⇤",

        -- Diagnostics Operations
        diag_toggle_virtual_text = "◚",
        diag_show_line_diagnostics = "≡",
        diag_show_buffer_diagnostics = "▤", -- Square with vertical bars (buffer list)
        diag_next_diagnostic = "⇢",
        diag_prev_diagnostic = "⇠",
        diag_next_error = "✗",           -- Ballot X (error)
        diag_prev_error = "✗",

        -- Indent Operations
        indent_smart_indent = "↦",       -- Maps to arrow (indent)
        indent_smart_outdent = "↤",      -- Maps from arrow (outdent)

        -- Treesitter Operations
        treesitter_toggle_folding = "☰", -- Three horizontal bars (folding lines)

        -- Buffer (BufferLine) Operations
        buffer_cycle_next = "⇞",         -- Page up (scroll next)
        buffer_cycle_prev = "⇟",         -- Page down (scroll prev)
        buffer_move_next = "▶",          -- Play/next (move buffer)
        buffer_move_prev = "◀",          -- Rewind/prev (move buffer)
        buffer_pick_close = "⊗",
        buffer_close_others = "⊘",       -- Circled division (close others)
        buffer_close_right = "⇥",        -- End arrow (close to right)
        buffer_close_left = "⇤",         -- Start arrow (close to left)
        buffer_pick = "⌖",               -- Scope (pick)
        buffer_toggle_pin = "⌽",          -- Circle with vertical line (pin)
        buffer_sort_directory = "⌂",     -- House (directory)
        buffer_sort_extension = "⬘",     -- Diamond minus (extension)
        buffer_sort_tabs = "☰",          -- Three horizontal bars (tabs)
        buffer_toggle_test_group = "◨",  -- Square with dots (group toggle)
        buffer_toggle_docs_group = "◨",

        -- Git Integration
        git_commits = "♽",               -- Recycle symbol (commits/history)
        git_branches = "⎇",              -- Branch icon
        git_status = "⚑",                -- Flag (status)

        -- Multicursor Operations
        multicursor_start = "◓",         -- Same as group icon (start multicursor)
        multicursor_clear = "✕",         -- Multiplication X
        multicursor_pattern_buffer = "⌕",
        multicursor_pattern_selection = "⌕",
        multicursor_toggle_word_cursor = "◎",
        multicursor_start_visual = "◓",
        multicursor_start_word = "◓",
        multicursor_all_pattern_matches = "⌕",
        multicursor_all_matches_selection = "⌕",
    },
}

-- ───────────────────────────────────────────────────────────────
-- Which-Key Setup Options
-- ───────────────────────────────────────────────────────────────

wk.setup({
    preset = "classic",
    delay = 200,
    win = {
        border = "none",
        padding = { 1, 2 },
        wo = {
            winblend = 2,
        },
    },
    layout = {
        width = { min = 20 },
        spacing = 3,
    },
    icons = {
        breadcrumb = sym.breadcrumb,
        separator = sym.separator,
        group = sym.group_icon, -- User preference: empty string for no icon before group label
        ellipsis = sym.ellipsis,
        mappings = false, -- Disable built-in icons for mappings
        rules = false,    -- Disable built-in rules for icon colors/styles
        colors = false,   -- Disable built-in icon coloring
        keys = sym.key,   -- Use our custom key icons
    },
})

-- ───────────────────────────────────────────────────────────────
-- Which-Key Mappings
-- ───────────────────────────────────────────────────────────────

local mappings = {
    -- Leader Key Prefix
    ["<leader>"] = {
        -- Main Top-Level Groups
        b = { name = sym.group.buffer .. " Buffer", _ = "which_key_ignore" },
        c = { name = sym.group.comment .. " Comment", _ = "which_key_ignore" },
        d = { name = sym.group.diagnostic .. " Diagnostic", _ = "which_key_ignore" },
        e = { name = sym.group.edit .. " Edit", _ = "which_key_ignore" },
        f = { name = sym.group.find .. " Find", _ = "which_key_ignore" },
        g = { name = sym.group.git .. " Git", _ = "which_key_ignore" },
        i = { name = sym.group.indent .. " Indent", _ = "which_key_ignore" },
        l = { name = sym.group.lsp .. " LSP", _ = "which_key_ignore" },
        m = { name = sym.group.multicursor .. " Multicursor", _ = "which_key_ignore" },
        s = { name = sym.group.buffer_cycle .. " Buffer Cycle", _ = "which_key_ignore" },
        t = { name = sym.group.trouble .. " Trouble", _ = "which_key_ignore" },
        a = { name = sym.group.outline .. " Outline", _ = "which_key_ignore" },
        r = { name = sym.group.replace .. " Replace", _ = "which_key_ignore" },
        z = { name = sym.group.treesitter .. " Treesitter", _ = "which_key_ignore" },

        -- Direct Leader Mappings (General Operations)
        ["<space>"] = sym.action.clear_search_highlight .. " Clear search highlight",
        n = sym.action.toggle_line_numbers .. " Toggle line numbers",
        y = sym.action.copy_entire_buffer .. " Copy entire buffer to clip",
        D = sym.action.delete_entire_buffer .. " Delete entire buffer",
        w = sym.action.save_and_close .. " Save and close",
        q = sym.action.force_close_buffer .. " Close without saving",
    },

    -- Outline/Aerial Operations (`<leader>a` prefix)
    ["<leader>a"] = {
        ["<leader>a"] = sym.action.outline_toggle_sidebar .. " Outline: Toggle sidebar", -- Self-mapping, if AerialToggle is also <leader>a
        A = sym.action.outline_toggle_navigation .. " Outline: Toggle navigation",
        f = sym.action.outline_focus_sidebar .. " Outline: Focus sidebar",
        i = sym.action.outline_show_symbol_count .. " Outline: Show symbol count",
        n = sym.action.outline_next_symbol .. " Outline: Next symbol",
        p = sym.action.outline_prev_symbol .. " Outline: Previous symbol",
        s = sym.action.outline_search_symbols .. " Outline: Search symbols",
    },

    -- Comment Group (`<leader>c` prefix)
    ["<leader>c"] = {
        c = { -- Subgroup for toggle comment types
            name = sym.comment_toggle_current .. " Toggle Comment",
            c = sym.action.comment_toggle_visual .. " Comment: Toggle for visual", -- For 'v' mode, shown under 'c'
            n = sym.action.comment_toggle_current .. " Comment: Toggle for current", -- For 'n' mode
        },
        a = sym.action.comment_append .. " Comment: Append",
        A = sym.action.comment_toggle_all .. " Comment: Toggle all",
        -- TODO Comment Insertion
        t = sym.action.comment_todo .. " Comment: TODO",
        f = sym.action.comment_fix .. " Comment: FIX",
        n = sym.action.comment_note .. " Comment: NOTE",
        h = sym.action.comment_hack .. " Comment: HACK",
        w = sym.action.comment_warn .. " Comment: WARN",
        p = sym.action.comment_perf .. " Comment: PERF",
        e = sym.action.comment_test .. " Comment: TEST",
        -- TODO Utilities
        d = sym.action.comment_toggle_todo_done .. " Comment: Toggle TODO/DONE",
        l = sym.action.comment_list_buffer_todos .. " Comment: List buffer TODOs",
    },

    -- Edit Group (`<leader>e` prefix)
    ["<leader>e"] = {
        r = sym.action.edit_replace_buffer_clipboard .. " Edit: Replace buffer with clipboard",
        -- The visual mode mapping for <leader>er will inherit this description
    },

    -- Replace (Spectre) Group (`<leader>r` prefix)
    ["<leader>r"] = {
        f = sym.action.replace_find .. " Replace: Find",
        -- The visual mode mapping for <leader>rf will inherit this description
    },

    -- LSP Actions (`<leader>l` prefix)
    ["<leader>l"] = {
        h = sym.action.lsp_hover .. " LSP: Show hover",
        f = sym.action.lsp_format .. " LSP: Format",
        r = sym.action.lsp_rename .. " LSP: Rename symbol",
        a = sym.action.lsp_code_actions .. " LSP: Code actions",
    },

    -- Find/Search Group (Telescope) (`<leader>f` prefix)
    ["<leader>f"] = {
        f = sym.action.find_files .. " Find: Files",
        p = sym.action.find_project_files .. " Find: Project files",
        b = sym.action.find_buffers .. " Find: Buffers",
        r = sym.action.find_recent .. " Find: Recent (Frecency)",
        g = sym.action.find_live_grep .. " Find: Live grep with args",
        w = sym.action.find_word_under_cursor .. " Find: Word under cursor",
        d = sym.action.find_diagnostics_current .. " Find: Diagnostics (current file)",
        D = sym.action.find_diagnostics_all .. " Find: Diagnostics (all files)",
        s = sym.action.find_doc_symbols .. " Find: Symbols (document)",
        S = sym.action.find_workspace_symbols .. " Find: Symbols (workspace)",
        h = sym.action.find_help_tags .. " Find: Help",
        k = sym.action.find_keymaps .. " Find: Keymaps",
        o = sym.action.find_options .. " Find: Options",
        c = sym.action.find_command_history .. " Find: Command history",
        H = sym.action.find_search_history .. " Find: Search history",
        t = sym.action.find_todos_priority .. " Find: TODOs with priority sorting",
    },

    -- Trouble Group (`<leader>t` prefix)
    ["<leader>t"] = {
        t = sym.action.trouble_toggle_diagnostics .. " Trouble: Toggle diagnostics",
        b = sym.action.trouble_buffer_diagnostics .. " Trouble: Buffer diagnostics",
        q = sym.action.trouble_quickfix_list .. " Trouble: Quickfix list",
        l = sym.action.trouble_location_list .. " Trouble: Location list",
        r = sym.action.trouble_lsp_references .. " Trouble: LSP references",
        d = sym.action.trouble_lsp_definitions .. " Trouble: LSP definitions",
        i = sym.action.trouble_lsp_implementations .. " Trouble: LSP implementations",
        s = sym.action.trouble_document_symbols .. " Trouble: Document symbols",
        c = sym.action.trouble_close_all .. " Trouble: Close all",
    },

    -- Diagnostics Group (`<leader>d` prefix)
    ["<leader>d"] = {
        v = sym.action.diag_toggle_virtual_text .. " Diagnostics: Toggle virtual text",
        l = sym.action.diag_show_line_diagnostics .. " Diagnostics: Show line diagnostics",
        b = sym.action.diag_show_buffer_diagnostics .. " Diagnostics: Show buffer diagnostics",
    },

    -- Indents Group (`<leader>i` prefix)
    ["<leader>i"] = {
        i = sym.action.indent_smart_indent .. " Indent: Smart indent line/selection",
        o = sym.action.indent_smart_outdent .. " Indent: Smart outdent line/selection",
    },

    -- Treesitter Group (`<leader>z` prefix)
    ["<leader>z"] = {
        z = sym.action.treesitter_toggle_folding .. " Toggle Treesitter folding",
    },

    -- Buffer Cycle/Scroll Group (`<leader>s` prefix)
    -- This group explicitly holds the BufferLineCycleNext/Prev mappings
    ["<leader>s"] = {
        s = sym.action.buffer_cycle_next .. " Scroll: Next buffer",
        S = sym.action.buffer_cycle_prev .. " Scroll: Previous buffer",
    },

    -- Buffer Operations (`<leader>b` prefix)
    ["<leader>b"] = {
        -- Buffer Subgroups
        c = { name = sym.sub_group.buffer_close .. " Close", _ = "which_key_ignore" },
        g = { name = sym.sub_group.buffer_group .. " Group", _ = "which_key_ignore" },
        m = { name = sym.sub_group.buffer_move .. " Move", _ = "which_key_ignore" },
        s = { name = sym.sub_group.buffer_sort .. " Sort", _ = "which_key_ignore" },
        -- Go to buffer by number
        ["1"] = sym.action.buffer_go_to_1 .. " Go to buffer 1",
        ["2"] = sym.action.buffer_go_to_2 .. " Go to buffer 2",
        ["3"] = sym.action.buffer_go_to_3 .. " Go to buffer 3",
        ["4"] = sym.action.buffer_go_to_4 .. " Go to buffer 4",
        ["5"] = sym.action.buffer_go_to_5 .. " Go to buffer 5",
        ["6"] = sym.action.buffer_go_to_6 .. " Go to buffer 6",
        ["7"] = sym.action.buffer_go_to_7 .. " Go to buffer 7",
        ["8"] = sym.action.buffer_go_to_8 .. " Go to buffer 8",
        ["9"] = sym.action.buffer_go_to_9 .. " Go to buffer 9",
        -- Direct BufferLine actions
        p = sym.action.buffer_pick .. " Pick buffer",
        P = sym.action.buffer_toggle_pin .. " Toggle pin buffer",
    },

    -- Buffer Close Subgroup (`<leader>bc` prefix)
    ["<leader>bc"] = {
        p = sym.action.buffer_pick_close .. " Pick buffer to close",
        o = sym.action.buffer_close_others .. " Close other buffers",
        r = sym.action.buffer_close_right .. " Close buffers to right",
        l = sym.action.buffer_close_left .. " Close buffers to left",
    },

    -- Buffer Move Subgroup (`<leader>bm` prefix)
    ["<leader>bm"] = {
        n = sym.action.buffer_move_next .. " Move buffer next",
        p = sym.action.buffer_move_prev .. " Move buffer prev",
    },

    -- Buffer Sort Subgroup (`<leader>bs` prefix)
    ["<leader>bs"] = {
        d = sym.action.buffer_sort_directory .. " Sort by directory",
        e = sym.action.buffer_sort_extension .. " Sort by extension",
        t = sym.action.buffer_sort_tabs .. " Sort by tabs",
    },

    -- Buffer Group Subgroup (`<leader>bg` prefix)
    ["<leader>bg"] = {
        t = sym.action.buffer_toggle_test_group .. " Toggle test group",
        d = sym.action.buffer_toggle_docs_group .. " Toggle docs group",
    },

    -- Git Integration (`<leader>g` prefix)
    ["<leader>g"] = {
        c = sym.action.git_commits .. " Git commits",
        b = sym.action.git_branches .. " Git branches",
        s = sym.action.git_status .. " Git status",
    },

    -- Multicursor Operations (`<leader>m` prefix)
    ["<leader>m"] = {
        -- The direct mapping for <Leader>m itself
        m = sym.action.multicursor_start .. " Multicursor: Start on word/selection",
        c = sym.action.multicursor_clear .. " Multicursor: Clear all",
        p = sym.action.multicursor_pattern_buffer .. " Multicursor: Pattern in buffer",
        u = sym.action.multicursor_toggle_word_cursor .. " Multicursor: Character under cursor",
        v = sym.action.multicursor_start_visual .. " Multicursor: Start on visual selection",
        w = sym.action.multicursor_start_word .. " Multicursor: Start on word",
        a = sym.action.multicursor_all_pattern_matches .. " Multicursor: All pattern matches",
    },

    -- Direct Navigation Keys (no leader)
    ["]"] = {
        name = sym.arrow_next .. " Next", -- Group for general "Next" navigation
        d = sym.action.diag_next_diagnostic .. " Diagnostics: Next diagnostic",
        e = sym.action.diag_next_error .. " Diagnostics: Next error",
        t = sym.action.todo_tag .. " Next todo comment", -- From todo-comments plugin
        -- NOTE: Original had "]T" as "⇢ Next Task" and "[T" as "⇠ Prev Trouble".
        T = sym.action.trouble_next_item .. " Next trouble item",
    },
    ["["] = {
        name = sym.arrow_prev .. " Prev", -- Group for general "Prev" navigation
        d = sym.action.diag_prev_diagnostic .. " Diagnostics: Previous diagnostic",
        e = sym.action.diag_prev_error .. " Diagnostics: Previous error",
        t = sym.action.todo_tag .. " Previous todo comment", -- From todo-comments plugin
        T = sym.action.trouble_prev_item .. " Previous trouble item",
    },
    g = {
        name = sym.arrow_go .. " Go", -- Group for "Go to" operations
        d = sym.lsp_nav_point .. " LSP: Go to definition",
        r = sym.lsp_nav_point .. " LSP: Go to references",
        i = sym.lsp_nav_point .. " LSP: Go to implementation",
        t = sym.lsp_nav_point .. " LSP: Go to type definition",
        ["<leader>T"] = sym.action.trouble_last_item .. " Last trouble item", -- g]T
        ["<leader>t"] = sym.action.trouble_first_item .. " First trouble item", -- g[T
    },
}

-- Add all the consolidated mappings to which-key
wk.add(mappings)

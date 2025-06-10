require('multicursor-nvim').setup()

local mc = require("multicursor-nvim")
local set = vim.keymap.set

-- Add or skip cursor above/below the main cursor
set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

-- Add or skip adding a new cursor by matching word/selection
set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

-- Toggle cursors on/off
set({"n", "x"}, "<c-q>", mc.toggleCursor)

-- Multi-cursor specific keymaps (only active when multiple cursors exist)
mc.addKeymapLayer(function(layerSet)

    -- Navigate between cursors
    layerSet({"n", "x"}, "<left>", mc.prevCursor)
    layerSet({"n", "x"}, "<right>", mc.nextCursor)
    
    -- Delete the main cursor
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)
    
    -- Clear all cursors with escape
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

-- Cursor appearance customization
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn"})
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})

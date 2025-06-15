require('Comment').setup({
    -- Disable all default mappings
    mappings = {
        basic = false,  -- Disables gcc, gbc, gc[motion], gb[motion]
        extra = false,  -- Disables gco, gcO, gcA
    },
})

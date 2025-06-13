require("multicursors").setup({
  -- Core settings
  DEBUG_MODE = false,
  create_commands = true,
  updatetime = 50,
  nowait = true,

  -- Mode keys for different multicursor modes
  mode_keys = {
    append = 'a',
    change = 'c',
    extend = 'e',
    insert = 'i',
  },

  -- Hint window configuration
  hint_config = {
    float_opts = {
      border = 'single',
    },
    position = 'bottom-right',
  },

  -- Generate hints for different modes
  generate_hints = {
    normal = true,
    insert = true,
    extend = true,
    config = {
      column_count = 1,
    },
  },

  -- Custom normal mode mappings
  normal_keys = {
    -- Clear other selections, keep main
    [','] = {
      method = function()
        local N = require("multicursors.normal_mode")
        N.clear_others()
      end,
      opts = { desc = 'Clear others' },
    },
    -- Comment all selections
    ['<C-/>'] = {
      method = function()
        require('multicursors.utils').call_on_selections(function(selection)
          vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
          local line_count = selection.end_row - selection.row + 1
          vim.cmd('normal ' .. line_count .. 'gcc')
        end)
      end,
      opts = { desc = 'Comment selections' },
    },
  },
})

-- Highlight customization
vim.api.nvim_set_hl(0, "MultiCursor", { reverse = true })
vim.api.nvim_set_hl(0, "MultiCursorMain", { reverse = true, bold = true })

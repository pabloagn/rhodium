local noice = require("noice")

-- ───────────────────────────────────────────────────────────────
-- Visual Elements: Unicode Symbols for Noice UI
-- ───────────────────────────────────────────────────────────────

local symbols = {
  -- General UI elements
  notification_prefix = "▶", -- Used for Dunst's format prefix "▶ %s"
  separator = "─", -- Horizontal line for separators (if needed, though not directly used for borders)

  -- Noice Keybind Icons
  redirect_cmd = "↦", -- Maps to / redirect (Command line redirection)
  last_message = "◴", -- Clock/history (Last message)
  history = "☰", -- List/menu (Message history)
  all_messages = "Σ", -- Sigma (All messages)
  dismiss_all = "✕", -- Multiplication X (Dismiss)
  picker = "⌕", -- Magnifying glass (Picker/Search)
  scroll_forward = "↓", -- Down arrow (Scroll forward)
  scroll_backward = "↑", -- Up arrow (Scroll backward)
}

-- ───────────────────────────────────────────────────────────────
-- Color Definitions (Based on Dunst Urgency Levels)
-- ───────────────────────────────────────────────────────────────

-- These colors define the background, foreground, and border (frame) colors
-- for different urgency levels, mirroring your Dunst setup.
local colors = {
  -- Urgency Low (for INFO messages, similar to Dunst's urgency_low)
  low_bg = "#1a1a1a",
  low_fg = "#888888",
  low_frame = "#2a2a2a",

  -- Urgency Normal (for WARN messages, similar to Dunst's urgency_normal)
  normal_bg = "#2a2a2a",
  normal_fg = "#ffffff",
  normal_frame = "#3c3c3c",

  -- Urgency Critical (for ERROR messages, similar to Dunst's urgency_critical)
  critical_bg = "#3a3a3a",
  critical_fg = "#ffffff",
  critical_frame = "#555555",

  -- Default/Generic colors for other Noice views (cmdline, popupmenu, mini if not explicitly routed)
  default_bg = "#262626",      -- Similar to Dunst's system/volume background
  default_fg = "#ffffff",      -- Default text color for general popups
  default_frame = "#3c3c3c",   -- Default border color
}

-- ───────────────────────────────────────────────────────────────
-- Noice Setup Configuration
-- ───────────────────────────────────────────────────────────────

noice.setup({
  event = "VeryLazy",   -- Only load Noice when Neovim is mostly initialized

  -- LSP message override settings
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  routes = {
    -- Route for specific messages (e.g., line/byte count) to the 'mini' view
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    -- Route `INFO` level messages to the `low_urgency` style
    {
      filter = { min_level = vim.log.levels.INFO },
      style = "low_urgency",
    },
    -- Route `WARN` level messages to the `normal_urgency` style
    {
      filter = { min_level = vim.log.levels.WARN },
      style = "normal_urgency",
    },
    -- Route `ERROR` and higher (CRITICAL) messages to the `critical_urgency` style
    {
      filter = { min_level = vim.log.levels.ERROR },
      style = "critical_urgency",
    },
    -- Add more specific routes if you have unique notification types
    -- that need specific styling (e.g., specific appname like in Dunst).
  },

  -- Presets for common Noice behaviors
  presets = {
    bottom_search = true,             -- Search results show at the bottom
    command_palette = true,           -- Command line uses a popup
    long_message_to_split = true,     -- Long messages go to a split window
  },

  -- Views: Define the appearance of different Noice popups
  views = {
    -- Main notification popup (used for vim.notify messages)
    notify = {
      backend = "notify",
      replace = true,
      merge = true,
      border = {
        style = "single",         -- Solid, non-rounded border
      },
      win_options = {
        winblend = 0,         -- Solid background (no transparency)
      },
      -- Default format, overridden by specific styles if applicable
      format = symbols.notification_prefix .. " %s\n%b",
    },
    -- Mini view (for quick, transient messages like "30L, 40B")
    mini = {
      backend = "mini",
      border = {
        style = "single",         -- Solid, non-rounded border
      },
      position = {
        row = -2,             -- Position at the bottom of the screen (adjust as needed)
        col = "100%",         -- Aligned to the right
      },
      win_options = {
        winblend = 0,                                      -- Solid background
      },
      format = symbols.notification_prefix .. " %s",       -- Simpler format for mini messages
    },
    -- Command line popup
    cmdline_popup = {
      border = {
        style = "single",         -- Solid, non-rounded border
      },
      win_options = {
        winblend = 0,         -- Solid background
      },
    },
    -- Popup menu (e.g., for completion or quick menus)
    popupmenu = {
      border = {
        style = "single",         -- Solid, non-rounded border
      },
      win_options = {
        winblend = 0,         -- Solid background
      },
    },
    -- Confirmation dialogues
    confirm = {
      border = {
        style = "single",         -- Solid, non-rounded border
      },
      win_options = {
        winblend = 0,         -- Solid background
      },
    },
  },

  -- Styles: Define how highlight groups are applied based on routes or message kinds
  styles = {
    -- Style for low urgency messages (e.g., INFO)
    low_urgency = {
      view = "notify",          -- Apply this style to the 'notify' view
      opts = {
        timeout = 8000,         -- Display for 8 seconds
        win_options = {
          -- Apply custom highlight groups for background, foreground, and border
          winhighlight = "NormalFloat:NoiceLowUrgency,FloatBorder:NoiceLowUrgencyBorder",
        },
      },
    },
    -- Style for normal urgency messages (e.g., WARN)
    normal_urgency = {
      view = "notify",
      opts = {
        timeout = 10000,         -- Display for 10 seconds
        win_options = {
          winhighlight = "NormalFloat:NoiceNormalUrgency,FloatBorder:NoiceNormalUrgencyBorder",
        },
      },
    },
    -- Style for critical urgency messages (e.g., ERROR)
    critical_urgency = {
      view = "notify",
      opts = {
        timeout = 0,         -- Stay until dismissed
        win_options = {
          winhighlight = "NormalFloat:NoiceCriticalUrgency,FloatBorder:NoiceCriticalUrgencyBorder",
        },
      },
    },
    -- Styles for other views that might not be routed by urgency levels
    mini = {
      view = "mini",
      opts = {
        win_options = {
          winhighlight = "NormalFloat:NoiceMiniBg,FloatBorder:NoiceMiniBorder",
        },
      },
    },
    cmdline_popup = {
      view = "cmdline_popup",
      opts = {
        win_options = {
          winhighlight = "NormalFloat:NoiceCmdlineBg,FloatBorder:NoiceCmdlineBorder",
        },
      },
    },
    popupmenu = {
      view = "popupmenu",
      opts = {
        win_options = {
          winhighlight = "NormalFloat:NoicePopupmenuBg,FloatBorder:NoicePopupmenuBorder",
        },
      },
    },
    confirm = {
      view = "confirm",
      opts = {
        win_options = {
          winhighlight = "NormalFloat:NoiceConfirmBg,FloatBorder:NoiceConfirmBorder",
        },
      },
    },
  },

  -- Keybindings for Noice operations (updated with Unicode symbols)
  keys = {
    -- Group for Noice keybinds in which-key
    { "<leader>sn",  "",                                  desc = "+noice" },
    -- Redirect command line input
    {
      "<S-Enter>",
      function() noice.redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = symbols.redirect_cmd .. " Redirect Cmdline",
    },
    -- Noice message history/management
    { "<leader>snl", function() noice.cmd("last") end,    desc = symbols.last_message .. " Noice Last Message" },
    { "<leader>snh", function() noice.cmd("history") end, desc = symbols.history .. " Noice History" },
    { "<leader>sna", function() noice.cmd("all") end,     desc = symbols.all_messages .. " Noice All" },
    { "<leader>snd", function() noice.cmd("dismiss") end, desc = symbols.dismiss_all .. " Dismiss All" },
    { "<leader>snt", function() noice.cmd("pick") end,    desc = symbols.picker .. " Noice Picker (Telescope/FzfLua)" },
    -- Scrolling in LSP documentation/messages
    {
      "<c-f>",
      function() if not noice.lsp.scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc = symbols.scroll_forward .. " Scroll Forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function() if not noice.lsp.scroll(-4) then return "<c-b>" end end,
      silent = true,
      expr = true,
      desc = symbols.scroll_backward .. " Scroll Backward",
      mode = { "i", "n", "s" },
    },
  },

  -- Config function: Executed after Noice is set up, ideal for setting highlight groups
  config = function(_, opts)
    -- HACK: Clear old messages that might appear from before Noice was active (e.g., during Lazy startup)
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    -- Apply the Noice setup options
    noice.setup(opts)

    -- ───────────────────────────────────────────────────────────────
    -- Define Custom Highlight Groups (called after Noice setup)
    -- These groups control the background, foreground, and border colors.
    -- ───────────────────────────────────────────────────────────────

    -- Highlight groups for urgency-based notification styles
    vim.api.nvim_set_hl(0, "NoiceLowUrgency", { bg = colors.low_bg, fg = colors.low_fg })
    -- For borders, only the 'fg' (foreground) color of the highlight group is used by FloatBorder
    vim.api.nvim_set_hl(0, "NoiceLowUrgencyBorder", { fg = colors.low_frame })

    vim.api.nvim_set_hl(0, "NoiceNormalUrgency", { bg = colors.normal_bg, fg = colors.normal_fg })
    vim.api.nvim_set_hl(0, "NoiceNormalUrgencyBorder", { fg = colors.normal_frame })

    vim.api.nvim_set_hl(0, "NoiceCriticalUrgency", { bg = colors.critical_bg, fg = colors.critical_fg })
    vim.api.nvim_set_hl(0, "NoiceCriticalUrgencyBorder", { fg = colors.critical_frame })

    -- Default/General highlight groups for other Noice views or elements that don't have urgency styles
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.default_frame })     -- Default border color for all floating windows

    -- Specific highlight groups for `mini`, `cmdline_popup`, `popupmenu`, `confirm` views
    -- These ensure they pick up a consistent default background/foreground/border if not overridden by a route/style
    vim.api.nvim_set_hl(0, "NoiceMiniBg", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceMiniBorder", { fg = colors.default_frame })

    vim.api.nvim_set_hl(0, "NoiceCmdlineBg", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceCmdlineBorder", { fg = colors.default_frame })

    vim.api.nvim_set_hl(0, "NoicePopupmenuBg", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = colors.default_frame })

    vim.api.nvim_set_hl(0, "NoiceConfirmBg", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = colors.default_frame })

    -- Original Noice highlight groups that might still need explicit definitions if not covered above
    vim.api.nvim_set_hl(0, "NoicePopup", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceFormatProgressDone", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceFormatProgressTodo", { bg = colors.default_bg, fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { bg = colors.default_bg, fg = colors.default_fg })
  end,
})

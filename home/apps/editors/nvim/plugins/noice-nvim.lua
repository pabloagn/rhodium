local noice = require("noice")

noice.setup({
  lsp = {
    -- Override markdown rendering to use Treesitter for cmp and other plugins
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },

    -- Enable hover and signature help via Noice
    hover = {
      enabled = true,
      silent = false, -- set to true to not show a message if hover is not available
      view = nil, -- when nil, use defaults from documentation
      opts = {} -- merged with defaults from documentation
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true, -- show signature help when typing a trigger character like `(`
        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
      opts = {} -- merged with defaults from documentation
    },

    -- Progress messages for LSP servers
    progress = {
      enabled = true,
      format = "lsp_progress", -- Use a custom format or the default
      format_done = "lsp_progress_done",
      throttle = 250,
      view = "mini",
    }
  },

  -- Message routing
  routes = {
    -- Route for specific brief messages to the 'mini' view
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" }, -- e.g., "10L, 200B"
          { find = "; after #%d+" }, -- e.g., "; after #1"
          { find = "; before #%d+" }, -- e.g., "; before #1"
        },
      },
      view = "mini",
    },

	-- Avoid yanked messages 
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+ lines yanked" },
          { find = "%d+ lines yanked into register %S" }, -- Catches yanks to specific registers
          { find = "yanked %d+ lines" }, -- Another possible format
        }
      },
      opts = { skip = true }, -- This tells Noice not to show these messages
    },
    -- Skip "written" messages if they become too noisy for you
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "^\"%S-\" %d+L, %d+B written$" } -- e.g., "filename.txt" 10L, 200B written
        }
      },
      opts = { skip = true }
    }
  },

  -- UI presets
  presets = {
    bottom_search = true,           -- Use a classic bottom cmdline for search
    command_palette = true,       -- Use a cmdline palette for :
    long_message_to_split = true, -- Long messages will be sent to a split
    inc_rename = true,              -- Enables an input dialog for inc_rename.nvim (if you use it)
    lsp_doc_border = true,          -- Add a border to hover docs and signature help
  },

  -- Further customization
  views = {
    mini = {
      win_options = { winblend = 0 }, -- Make the 'mini' view opaque
      position = { row = "90%", col = "50%" } -- Center 'mini' view at 90% screen height
    },
    cmdline_popup = {
      position = { row = "20%", col = "50%" },
      size = { width = "60%" },
    },
  },

  -- Configure command line appearance
  cmdline = {
    enabled = true, -- General cmdline override
    view = "cmdline_popup", -- Or "cmdline" for classic, "cmdline_popup" for popup
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
      help = { pattern = "^:%s*help%s+", icon = "" },
    },
  },
})

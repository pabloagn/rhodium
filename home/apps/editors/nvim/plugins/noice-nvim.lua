local noice = require("noice")

-- Define custom highlight groups for Noice.
-- Adjust these colors to match your colorscheme.
-- Example colors (Catppuccin Macchiato inspired):
vim.api.nvim_set_hl(0, "NoicePopupBg", { bg = "#181926", fg = "#cad3f5" })
vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#6e738d" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#8aadf4" })
vim.api.nvim_set_hl(0, "NoiceMiniFg", { fg = "#eed49f" })
vim.api.nvim_set_hl(0, "NoiceMiniBg", { bg = "#11111b", blend = 20 })

noice.setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    opts = {},
    format = {
      cmdline = { pattern = "^:", icon = "❯ ", lang = "vim", hl_group = "NoiceCmdlineIcon" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", hl_group = "NoiceCmdlineIcon" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", hl_group = "NoiceCmdlineIcon" },
      filter = { pattern = "^:%s*!", icon = " ", lang = "bash", hl_group = "NoiceCmdlineIcon" },
      lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua", hl_group = "NoiceCmdlineIcon" },
      help = { pattern = "^:%s*help%s+", icon = " ", lang = "vim", hl_group = "NoiceCmdlineIcon" },
      input = { icon = "› ", hl_group = "NoiceCmdlineIcon" },
    },
  },

  lsp = {
    progress = { enabled = true, view = "status_popup" }, -- Renamed from 'mini'
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = { enabled = true, view = "hover_custom" },
    signature = { enabled = true, view = "signature_custom" },
  },

  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },

  routes = {
    {
      filter = { event = "msg_show", any = {
          { find = "⚠️ WARNING vim%.tbl_islist is deprecated" },
          { find = "⚠️ WARNING vim%.validate is deprecated" },
      }},
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" } }},
      view = "status_popup", -- Renamed from 'mini'
    },
    {
      filter = { event = "msg_show", any = { { find = "%d+ lines yanked" }}},
      opts = { skip = true },
    },
  },

  views = {
    cmdline_popup = {
      position = { row = "25%", col = "50%" },
      size = { width = "50%", min_width = 40, height = "auto" },
      border = {
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        padding = { 0, 2 },
        text = { top_align = "center" },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
      zindex = 250,
    },
    popup = {
      position = "50%",
      size = { width = "60%", height = "auto" },
      border = { style = { " ", " ", " ", " ", " ", " ", " ", " " } },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    status_popup = { -- Renamed from 'mini'
      backend = "popup", -- This is crucial
      position = { row = 1, col = "100%-30" },
      size = { max_height = 1, min_width = 5, max_width = 28 },
      timeout = 3500,
      zindex = 300,
      border = { style = "none", padding = {0, 1} },
      win_options = {
        winhighlight = "Normal:NoiceMiniBg,NormalNC:NoiceMiniBg",
        winblend = 10,
        wrap = false,
        linebreak = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
        number = false,
        relativenumber = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
      },
      -- Temporarily removed filter_options and format to simplify for debugging
      -- filter_options = {},
      -- format = function(message) ... end,
    },

    hover_custom = {
      view = "hover",
      border = { style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    signature_custom = {
      view = "signature",
      border = { style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },
  },
})

vim.defer_fn(function()
  if pcall(require, "noice") then vim.notify = require("noice").notify end
end, 100)

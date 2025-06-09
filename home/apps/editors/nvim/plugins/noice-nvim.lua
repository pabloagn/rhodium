local noice = require("noice")

-- Define custom highlight groups for Noice.
-- Adjust these colors to match your colorscheme.
-- Example colors (Catppuccin Macchiato inspired):
vim.api.nvim_set_hl(0, "NoicePopupBg", { bg = "#181926", fg = "#cad3f5" })     -- Darker background, light text
vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#6e738d" })            -- Muted border (e.g., lavender gray)
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#8aadf4" })              -- Icon color (e.g., blue)
vim.api.nvim_set_hl(0, "NoiceMiniFg", { fg = "#eed49f" })                   -- Mini view text (e.g., yellow/gold)
vim.api.nvim_set_hl(0, "NoiceMiniBg", { bg = "#11111b", blend = 20 })        -- Very dark, slightly transparent bg for mini

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
    progress = { enabled = true, view = "mini" },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = { enabled = true, view = "hover_custom" },          -- Use custom styled hover
    signature = { enabled = true, view = "signature_custom" }, -- Use custom styled signature
  },

  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false, -- Set to true if you use inc_rename.nvim
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
      view = "mini",
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
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Elegant rounded
        padding = { 0, 2 }, -- Horizontal padding
        text = { top_align = "center" },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0, -- Solid background
      },
      zindex = 250,
    },
    popup = {
      position = "50%", -- Centered
      size = { width = "60%", height = "auto" },
      border = { style = { " ", " ", " ", " ", " ", " ", " ", " " } }, -- Minimalist, can use thin lines
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    mini = {
      position = { row = 1, col = "100%-28" }, -- Top-right status
      timeout = 2500,
      max_height = 1,
      max_width = 25,
      zindex = 300,
      border = { style = "none", padding = {0,1} },
      win_options = {
        winhighlight = "Normal:NoiceMiniBg,NormalNC:NoiceMiniBg,StatusLine:NoiceMiniBg,StatusLineNC:NoiceMiniBg",
      },

      filter_options = {}, -- Remove filter options to show content directly
      format = function(message)
        if message.progress and message.progress.title then
          return string.format("◌ %s: %s", message.progress.client, message.progress.title)
        elseif type(message.content) == "string" then
          return ":: " .. message.content
        end
        return ""
      end,
    },

    hover_custom = { -- Custom view for LSP hover
      view = "hover", -- Inherits from default hover
      border = { style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    signature_custom = { -- Custom view for LSP signature
      view = "signature", -- Inherits from default signature
      border = { style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },
  },
})

-- Ensure Noice handles all vim.notify messages
vim.defer_fn(function()
  if require("noice") then vim.notify = require("noice").notify end
end, 100)


local noice = require("noice")

-- ✦ Sacred aesthetic highlights
vim.api.nvim_set_hl(0, "NoicePopupBg", { bg = "#181926", fg = "#cad3f5" })
vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#6e738d" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#8aadf4" })
vim.api.nvim_set_hl(0, "NoiceMiniBg", { bg = "#11111b" })

noice.setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline     = { pattern = "^:",      icon = "❯ ", lang = "vim",   hl_group = "NoiceCmdlineIcon" },
      search_down = { pattern = "^/",      icon = "🔍 ", lang = "regex", hl_group = "NoiceCmdlineIcon" },
      search_up   = { pattern = "^%?",     icon = "🔎 ", lang = "regex", hl_group = "NoiceCmdlineIcon" },
      filter      = { pattern = "^:%s*! ", icon = "🖥 ", lang = "bash",  hl_group = "NoiceCmdlineIcon" },
      lua         = { pattern = "^:%s*lua",icon = " ", lang = "lua",   hl_group = "NoiceCmdlineIcon" },
      help        = { pattern = "^:%s*help",icon = "❓", lang = "vim",   hl_group = "NoiceCmdlineIcon" },
      input       = { icon = "› ", hl_group = "NoiceCmdlineIcon" },
    },
  },

  lsp = {
    progress = { enabled = true, view = "status_popup" },
    hover    = { enabled = true, view = "hover_popup" },
    signature = { enabled = true, view = "signature_popup" },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  views = {
    cmdline_popup = {
      position = { row = "30%", col = "50%" },
      size = { width = 60, height = "auto" },
      border = {
        style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
      zindex = 200,
    },

    popup = {
      position = "50%",
      size = { width = "60%", height = "auto" },
      border = {
        style = { " ", " ", " ", " ", " ", " ", " ", " " },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    status_popup = {
      backend = "popup",
      position = { row = 1, col = "100%-30" },
      size = { width = 28, height = 1 },
      timeout = 3000,
      border = { style = "none", padding = { 0, 1 } },
      win_options = {
        winhighlight = "Normal:NoiceMiniBg",
        winblend = 0,
        number = false,
        relativenumber = false,
        signcolumn = "no",
      },
      zindex = 300,
    },

    hover_popup = {
      border = {
        style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },

    signature_popup = {
      border = {
        style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = "Normal:NoicePopupBg,FloatBorder:NoicePopupBorder",
        winblend = 0,
      },
    },
  },

  routes = {
    -- Skip annoying spam
    {
      filter = { event = "msg_show", find = "%d+L, %d+B" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "written" },
      opts = { skip = true },
    },
  },

  presets = {
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
})

-- Optional: use Noice as global notifier
vim.defer_fn(function()
  vim.notify = require("noice").notify
end, 100)

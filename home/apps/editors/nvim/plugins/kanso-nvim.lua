require("kanso").setup({
  bold = true,
  italics = true,
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = {},
  typeStyle = {},
  transparent = true,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = { zen = {}, pearl = {}, ink = {}, mist = {}, all = {} },
  },
  overrides = function(colors)
    return {
      -- Telescope
      TelescopeNormal = { bg = "#0f1316", fg = "#DCE0E8" },
      TelescopeBorder = { fg = "#22262d", bg = "#0f1316" },
      TelescopePromptBorder = { fg = "#22262d", bg = "#0f1316" },
      TelescopeResultsBorder = { fg = "#22262d", bg = "#0f1316" },
      TelescopePreviewBorder = { fg = "#22262d", bg = "#0f1316" },
      TelescopeSelection = { fg = "#DCE0E8", bg = "#1f272e" },
      TelescopePromptPrefix = { fg = "#5c6066" },

      -- WhichKey
      WhichKeyNormal = { bg = "#090E13" },
      WhichKeyBorder = { fg = "#22262D", bg = "#090E13" },
      WhichKeyTitle = { bg = "#090E13" },

      -- Noice
      NoiceCmdlinePopup = { bg = "#0f1316", fg = "#c0caf5" },
      NoiceCmdlinePopupBorder = { fg = "#5c6066", bg = "#0f1316" },
    }
  end,
  theme = "zen",
  background = {
    dark = "zen",
    light = "pearl",
  },
})
vim.cmd("colorscheme kanso")

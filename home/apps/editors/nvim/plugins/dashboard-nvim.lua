require('dashboard').setup {
  theme = 'hyper',
  config = {
    shortcut = {
      -- { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
      { desc = '⊹ Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
      -- { desc = '⊹ Apps', group = 'DiagnosticHint', action = 'Telescope app', key = 'a' },
      { desc = '⊹ Rhodium', group = 'Number', action = 'Telescope dotfiles', key = 'd' },
    },
    packages = { enable = true },
    project = { enable = true, limit = 8, icon = '', label = '', action = 'Telescope find_files cwd=' },
    mru = { enable = true, limit = 10, icon = '', label = '', cwd_only = false },
    footer = { '', '-------------- § --------------' },
  },
}

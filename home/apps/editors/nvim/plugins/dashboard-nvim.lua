require('dashboard').setup {
  theme = 'hyper',
  config = {
    shortcut = {
      { desc = '⊹ Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
      { desc = '⊹ Rhodium', group = 'Number', action = 'Telescope dotfiles', key = 'r' },
    },
    packages = { enable = true },
    project = { enable = true, limit = 8, icon = '', label = '', action = 'Telescope find_files cwd=' },
    mru = { enable = true, limit = 10, icon = '', label = '', cwd_only = false },
    footer = { '', '-------------- § --------------' },
  },
}

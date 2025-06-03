{ ... }:

''
  # FZF keybindings (this gives you Ctrl+T for files, Alt+C for dirs)
  fzf --fish | source

  # Custom keybindings
  bind \cr '_atuin_search'  # Ctrl+R for atuin
  bind -M insert \cr '_atuin_search'

  # Working directory navigation
  bind \eh 'prevd; commandline -f repaint'  # Alt+H previous dir
  bind \el 'nextd; commandline -f repaint'  # Alt+L next dir
''

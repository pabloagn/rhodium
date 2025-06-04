{ ... }:

''
  # List commands
  abbr -a ls 'eza -l'
  abbr -a la 'eza -la'
  abbr -a llc 'eza -1'
  abbr -a lac 'eza -1a'
  abbr -a lld 'eza -l'
  abbr -a lad 'eza -la'
  abbr -a lli 'eza --icons -l'
  abbr -a lai 'eza --icons -la'
  abbr -a l2 'eza --icons -l -T -L=2'
  abbr -a l3 'eza --icons -l -T -L=3'
  abbr -a llt 'eza -T'
  abbr -a lat 'eza -Ta'
  abbr -a tree 'eza -Ta'
  abbr -a lat1 'eza -Ta -L=1'
  abbr -a lat2 'eza -Ta -L=2'
  abbr -a lat3 'eza -Ta -L=3'
  abbr -a lat4 'eza -Ta -L=4'
  abbr -a lat5 'eza -Ta -L=5'
  abbr -a llty 'eza -T | wl-copy'
  abbr -a laty 'eza -Ta | wl-copy'

  # Navigation
  abbr -a cd 'z'
  abbr -a .. 'cd ..'
  abbr -a ... 'cd ../..'
  abbr -a .... 'cd ../../..'
  abbr -a ..... 'cd ../../../..'

  # View
  abbr -a cat 'bat'
  abbr -a lf 'yy'

  # Search
  abbr -a locate 'plocate'
  abbr -a fd 'fd -Lu'
  abbr -a find 'fd'
  abbr -a grep 'rga'

  # Editor
  abbr -a vim 'hx'
  abbr -a vi 'hx'
  abbr -a v 'hx'

  # Clipboard
  abbr -a yank 'wl-copy'

  # History
  # abbr -a h 'history'
  # abbr -a hs 'history | grep'
  # abbr -a hsi 'history | grep -i'
  # abbr -a hist 'history | bat --language=bash --style=numbers'
  abbr -a hist 'fzf-history-widget'

  # General
  abbr -a cl 'clear'
  abbr -a htop 'btm'
  abbr -a neofetch 'disfetch'
  abbr -a nf 'disfetch'
  abbr -a !! 'sudo $history[1]'

  # Core Directories
  # abbr -a gd "z $"
  # abbr -a gc "z ${configDir}"
  # abbr -a gr 'z $RHODIUM'
  # abbr -a gp "z ${homeDir}/projects"

  # Fuzzy
  abbr -a fzf 'fzf'
  abbr -a fzd 'zi'
  abbr -a fzc 'fzf-history-widget'

  # Git
  abbr -a gst 'git status'
  abbr -a gad 'git add .'
  abbr -a gcm 'git commit -m'
  abbr -a gpu 'git push -u origin main'
  abbr -a grm 'git rm -r --cached .'

  # IDEs (suppress Electron warnings)
  abbr -a code 'code 2>/dev/null'
  abbr -a cursor 'cursor 2>/dev/null'

  # Utils
  # Display all abbreviations and pipe to fzf
  abbr -a aliases 'abbr --show | fzf'
''

{ ... }:

''
  # Smart history - Atuin for main history
  set -gx ATUIN_NOBIND true
  atuin init fish --disable-up-arrow | source
''

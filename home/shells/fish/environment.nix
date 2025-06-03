{ config, ... }:

''
  # Core environment
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx PAGER "less -R"

  # Custom paths
  set -gx RHODIUM ${config.home.homeDirectory}/rhodium
''

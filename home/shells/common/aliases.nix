{...}: {
  # List commands
  ls = "eza -l";
  la = "eza -la";
  llc = "eza -1";
  lac = "eza -1a";
  lld = "eza -l";
  lad = "eza -la";
  lli = "eza --icons -l";
  lai = "eza --icons -la";
  l2 = "eza --icons -l -T -L=2";
  l3 = "eza --icons -l -T -L=3";
  llt = "eza -T";
  lat = "eza -Ta";
  lat1 = "eza -Ta -L=1";
  lat2 = "eza -Ta -L=2";
  lat3 = "eza -Ta -L=3";
  lat4 = "eza -Ta -L=4";
  lat5 = "eza -Ta -L=5";
  llty = "eza -T | wl-copy";
  laty = "eza -Ta | wl-copy";

  # Navigation
  cd = "z";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # View
  cat = "bat";
  lf = "yy";

  # Search
  locate = "plocate";
  fda = "fd -Lu"; # Find All
  find = "fd"; # Find

  # Editor
  vim = "nvim";
  vi = "nvim";
  v = "nvim";

  # Clipboard
  y = "wl-copy"; # Yank

  # History
  h = "history";
  hs = "history | grep";
  hsi = "history | grep -i";
  hist = "fzf-history-widget";

  # General
  cl = "clear";
  htop = "btm";
  neofetch = "fastfetch";
  nf = "fastfetch";
  "!!" = "sudo $history[1]";

  # Core Directories
  gd = "z $HOME_DOWNLOADS";
  gc = "z $XDG_CONFIG_HOME";
  ge = "z $XDG_CACHE_HOME";
  gr = "z $RHODIUM";
  gp = "z $HOME_PROJECTS";
  ga = "z $HOME_ACADEMIC";
  gs = "z $HOME_SOLENOIDLABS";
  gw = "z $HOME_PROFESSIONAL";
  gv = "z $HOME_VAULTS";

  # Fuzzy
  # fzd = "zi";
  fzh = "fzf-history-widget";

  # Git
  gst = "git status"; # Check git repo status
  gad = "git add ."; # Stage all files under current dir
  gcm = "cz commit"; # Create a new commit (commitizen)
  gbp = "cz bump"; # Bump version and update changelog (commitizen)
  gch = "cz changelog"; # Generate changelog (commitizen)
  gck = "cz check"; # Validate commit messages (commitizen)
  gvr = "cz version"; # Show version information (commitizen)
  gin = "cz init"; # Initialize Commitizen configuration (commitizen)
  gpu = "git push -u origin main"; # Push to main
  grm = "git rm -r --cached ."; # Remove remote cache

  # IDEs
  code = "code 2>/dev/null";
  cursor = "cursor 2>/dev/null";

  # See-utils
  sa = "alias | fzf"; # See aliases
  sv = "env | sort | fzf"; # See environment vars
}

{ ... }:
{
  # --- Archive Management ---
  untar = "tar -xvf";
  untargz = "tar -xzvf";
  untarxz = "tar -xJvf";

  # --- Niri ---
  nms = "niri msg --json event-stream | jq '.'"; # Niri msg stream in json

  # --- Clipboard ---
  y = "wl-copy"; # Yank

  # --- Disk Usage ---
  du = "dust"; # Better disk usage analyzer
  df = "duf"; # Better df alternative

  # --- Docker ---
  d = "docker";
  dc = "docker compose";
  dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";

  # --- Editor ---
  vim = "nvim";
  vi = "nvim";
  v = "nvim";

  # --- File Operations ---
  cp = "cp -iv"; # Interactive & verbose copy
  mv = "mv -iv"; # Interactive & verbose move
  rm = "trash-put"; # Move to trash instead of delete
  mkdir = "mkdir -pv"; # Create parent dirs & verbose

  # --- General ---
  cl = "clear"; # Clear previous commands
  htop = "btm"; # Bottom
  neofetch = "fastfetch"; # Fetch
  nf = "fastfetch"; # Fetch
  "!!" = "sudo $history[1]"; # Last command with sudo
  notify-catch = ''dbus-monitor "interface='org.freedesktop.Notifications'"''; # Catch notificaton info sent by d-bus

  # --- Git ---
  gad = "git add ."; # Stage all files under current dir
  gbp = "cz bump"; # Bump version and update changelog (commitizen)
  gch = "cz changelog"; # Generate changelog (commitizen)
  gck = "cz check"; # Validate commit messages (commitizen)
  gcm = "cz commit"; # Create a new commit (commitizen)
  gin = "cz init"; # Initialize Commitizen configuration (commitizen)
  gpu = "git push -u origin main"; # Push to main
  grm = "git rm -rf --cached ."; # Remove remote cache recursive force
  gst = "git status"; # Check git repo status
  gvr = "cz version"; # Show version information (commitizen)

  # --- History ---
  h = "fzf-history-widget"; # Interactive history search
  hs = "history | rg"; # Ripgrep history
  hsi = "history | rg -i"; # Grep history ignore case
  hist = "fzf-history-widget";

  # --- Ides ---
  code = "code 2>/dev/null"; # Launch code cleanly
  cursor = "cursor 2>/dev/null"; # Launch cursor cleanly

  # --- Jumpers ---
  # Go to ->
  gC = "z $XDG_CACHE_HOME"; # Go cache home
  gD = "z $DOOMDIR"; # Go config Doom Emacs
  ga = "z $HOME_ACADEMIC"; # Go Academic
  gb = "z $XDG_BIN_HOME"; # Go bin home
  gc = "z $XDG_CONFIG_HOME"; # Go config home
  gd = "z $HOME_DOWNLOADS"; # Go downloads
  gh = "z $HOME"; # Go home
  gi = "zi"; # Go interactive
  gp = "z $HOME_PROJECTS"; # Go projects
  gr = "z $RHODIUM"; # Go Rhodium
  gS = "z $HOME_SOLENOIDLABS"; # Go SolenoidLabs
  gv = "z $HOME_VAULTS"; # Go Obsidian Vaults
  gw = "z $HOME_PROFESSIONAL"; # Go Professional

  # Go to -> 2
  gsg = "z $HOME_SOLENOIDLABS/glassflow"; # Go Solenoid Labs/Glassflow

  # --- Openers ---
  # Go to; list ->
  gal = "z $HOME_ACADEMIC; yy";
  gbl = "z $XDG_BIN_HOME; yy";
  gcl = "z $XDG_CONFIG_HOME; yy";
  gdl = "z $HOME_DOWNLOADS; yy";
  gel = "z $XDG_CACHE_HOME; yy";
  ghl = "z $HOME; yy";
  gpl = "z $HOME_PROJECTS; yy";
  grl = "z $RHODIUM; yy";
  gsl = "z $HOME_SOLENOIDLABS; yy";
  gvl = "z $HOME_VAULTS; yy";
  gwl = "z $HOME_PROFESSIONAL; yy";

  # --- List ---
  # List ->
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

  # --- Navigation ---
  # Change dir ->
  cd = "z";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # --- Network ---
  ping = "gping"; # Graph ping with TUI
  dig = "dog"; # Modern DNS lookup
  ip = "ip -c"; # Colorized ip command
  myip = "curl -s ifconfig.me";

  # --- Process Management ---
  ps = "procs"; # Modern ps replacement

  # --- Quick Calculations ---
  calc = "qalc"; # Or "bc -l"

  # --- Quick Edits ---
  bashrc = "nvim ~/.bashrc";
  zshrc = "nvim ~/.zshrc";

  # --- Safety Nets ---
  chown = "chown --preserve-root";
  chmod = "chmod --preserve-root";
  chgrp = "chgrp --preserve-root";

  # --- Search ---
  locate = "plocate";
  fda = "fd -Lu"; # Find All

  # --- See-utils ---
  sa = "alias | fzf"; # See aliases
  sv = "env | sort | fzf"; # See environment vars

  # --- System Info ---
  free = "free -h"; # Human readable memory

  # --- Time Savers ---
  now = "date +'%Y-%m-%d %H:%M:%S'";
  week = "date +%V";

  # --- View ---
  cat = "bat";
  cata = "cat * | y"; # cat all and yank
  catr = "find . -type f | xargs -I {} sh -c 'echo \"{}\"; cat \"{}\"; echo \"-----\"' | wl-copy"; # cat all recursive and yank
  headr = "find . -type f | xargs -I {} sh -c 'echo \"{}\"; head \"{}\"; echo \"-----\"' | wl-copy"; # head all recursive and yank
  lf = "yy";
}

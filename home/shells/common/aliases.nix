{...}: {
  # --- Archive Management ---
  untar = "tar -xvf";
  untargz = "tar -xzvf";
  untarxz = "tar -xJvf";
  
  # --- Clipboard ---
  y = "wl-copy"; # Yank
  
  # --- Disk Usage ---
  du = "dust";  # Better disk usage analyzer
  df = "duf";  # Better df alternative
  
  # --- Docker ---
  d = "docker";
  dc = "docker compose";
  dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
  
  # --- Editor ---
  vim = "nvim";
  vi = "nvim";
  v = "nvim";
  
  # --- File Operations ---
  cp = "cp -iv";  # Interactive & verbose copy
  mv = "mv -iv";  # Interactive & verbose move
  rm = "trash-put";  # Move to trash instead of delete
  mkdir = "mkdir -pv";  # Create parent dirs & verbose
  
  # --- Fuzzy ---
  # fzd = "zi";
  # fzh = "fzf-history-widget";
  
  # --- General ---
  cl = "clear";
  htop = "btm";
  neofetch = "fastfetch";
  nf = "fastfetch";
  "!!" = "sudo $history[1]";
  
  # --- Git ---
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
  
  # --- History ---
  h = "history";
  hs = "history | grep";
  hsi = "history | grep -i";
  hist = "fzf-history-widget";
  
  # --- Ides ---
  code = "code 2>/dev/null"; # Launch code cleanly
  cursor = "cursor 2>/dev/null"; # Launch cursor cleanly
  
  # --- Jumpers ---
  gh = "z $HOME";
  gd = "z $HOME_DOWNLOADS";
  gc = "z $XDG_CONFIG_HOME";
  ge = "z $XDG_CACHE_HOME";
  gr = "z $RHODIUM";
  gp = "z $HOME_PROJECTS";
  ga = "z $HOME_ACADEMIC";
  gs = "z $HOME_SOLENOIDLABS";
  gw = "z $HOME_PROFESSIONAL";
  gv = "z $HOME_VAULTS";
  
  # --- List ---
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
  cd = "z";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  
  # --- Network ---
  ping = "gping";  # Graph ping with TUI
  dig = "dog";  # Modern DNS lookup
  ip = "ip -c";  # Colorized ip command
  myip = "curl -s ifconfig.me";
  
  # --- Process Management ---
  ps = "procs";  # Modern ps replacement
  kill = "fzf-kill-widget";  # Interactive process killer
  
  # --- Quick Calculations ---
  calc = "qalc";  # Or "bc -l"
  
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
  free = "free -h";  # Human readable memory
  
  # --- Time Savers ---
  now = "date +'%Y-%m-%d %H:%M:%S'";
  week = "date +%V";
  
  # --- View ---
  cat = "bat";
  cata = "cat * | y"; # cat all and yank
  catr = "find . -type f | xargs -I {} sh -c 'echo \"{}\"; cat \"{}\"; echo \"-----\"' | wl-copy"; # cat all recursive and yank
  lf = "yy";
}

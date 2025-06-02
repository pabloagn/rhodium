{ config, ... }:

# TODO: Complete this file properly:
# - Add more aliases
# - Use conditional packaging
let
  homeDir = config.home.homeDirectory;
  configdir = config.xdg.configHome;
in
{
  # List
  # -------------------------------------

  # List List Clean
  llc = "eza -1";

  # List All Clean
  lac = "eza -1a";

  # List List Details
  lld = "eza -l";

  # List All Details
  lad = "eza -la";

  # List List Icons
  lli = "eza --icons -l";

  # List All Icons
  lai = "eza --icons -la";

  l2 = "eza --icons -l -T -L=2";
  l3 = "eza --icons -l -T -L=3";

  # List List Tree
  llt = "eza -T";

  # List All Tree
  lat = "eza -Ta";
  tree = "eza -Ta"; # In the meantime while I gain confidence with above

  lat1 = "eza -Ta -L=1";
  lat2 = "eza -Ta -L=2";
  lat3 = "eza -Ta -L=3";
  lat4 = "eza -Ta -L=4";
  lat5 = "eza -Ta -L=5";


  # List List Tree Yank
  llty = "eza -T | wl-copy";

  # List All Tree Yank
  laty = "eza -Ta | wl-copy";

  # Navigation
  # -------------------------------------
  cd = "z";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # View
  # -------------------------------------
  cat = "bat";
  lf = "yy";

  # Search
  # -------------------------------------

  # Locate (requires plocate)
  locate = "plocate";

  # Find (simple)
  fd = "fd -Lu";
  find = "fd";

  # Ripgrep-All (requires ripgrep-all)
  grep = "rga";

  # Editor
  # -------------------------------------
  vim = "hx";
  vi = "hx";
  v = "hx";

  # Clipboard
  # -------------------------------------
  yank = "wl-copy";

  # General
  # -------------------------------------
  cl = "clear";
  htop = "btm";
  neofetch = "disfetch";
  nf = "disfetch";

  # Core Directories
  gc = "z ${configdir}";
  gr = "z $RHODIUM";
  gp = "z ${homeDir}/projects";

  # Fuzzy
  fzf = "fzf";
  fzd = "zi";
  fzc = "fzf-history-widget";

  # Git
  gst = "git status";
  gad = "git add .";
  gcm = "git commit -m";
  gpu = "git push -u origin main";
  grm = "git rm -r --cached .";

  # IDEs
  # Fix the annoying ozone warning for Electron apps (does not affect functionality)
  code = "code 2>/dev/null";
  cursor = "cursor 2>/dev/null";
}

# home/shell/common/aliases.nix

{
  # List
  l = "eza --icons";
  ls = "eza --icons -l -T -L=1";
  l2 = "eza --icons -l -T -L=2";
  l3 = "eza --icons -l -T -L=3";
  la = "eza --icons -la -T -L=1";

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
  fd = "fd -Lu";
  find = "fd";
  grep = "rg";

  # Editor
  vim = "hx";
  vi = "hx";
  v = "hx";

  # General
  cl = "clear";
  htop = "btm";
  neofetch = "disfetch";
  nf = "disfetch";

  # Core Directories
  gc = "z .config";
  gr = "z $RHODIUM";
  gp = "z projects";

  # Fuzzy
  fzf = "fzf";
  fzd = "zi";
  fzc = "fzf-history-widget";

  # Git
  gst = "git status";
  gad = "git add *";
  gpu = "git push -u origin master";
  grm = "git rm -r --cached .";

  # VS Code
  # Fix the annoying ozone warning (does not affect functionality)
  code = "code 2>/dev/null";
  cursor = "cursor 2>/dev/null";
}

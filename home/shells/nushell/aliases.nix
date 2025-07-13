{ ... }:
{
  programs.nushell.shellAliases = {
    # List commands
    # ls = "eza -l";
    # la = "eza -la";
    # llc = "eza -1";
    # lac = "eza -1a";
    # lld = "eza -l";
    # lad = "eza -la";
    # lli = "eza --icons -l";
    # lai = "eza --icons -la";
    l2 = "eza --icons -l -T -L=2";
    l3 = "eza --icons -l -T -L=3";
    llt = "eza -T";
    lat = "eza -Ta";
    tree = "eza -Ta";
    lat1 = "eza -Ta -L=1";
    lat2 = "eza -Ta -L=2";
    lat3 = "eza -Ta -L=3";
    lat4 = "eza -Ta -L=4";
    lat5 = "eza -Ta -L=5";

    # Navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # View
    cat = "bat";

    # Search
    # locate = "plocate";
    # fda = "fd -Lu";
    # find = "fd";

    # Editor
    vim = "nvim";
    vi = "nvim";
    v = "nvim";

    # Clipboard
    y = "wl-copy";

    # History
    h = "history";

    # General
    cl = "clear";
    htop = "btm";
    neofetch = "fastfetch";
    nf = "fastfetch";

    # Git
    gst = "git status";
    gad = "git add .";
    gcm = "git commit -m";
    gpu = "git push -u origin main";
    grm = "git rm -r --cached .";

    # IDEs
    code = "code 2>/dev/null";

    # Fuzzy
    fzf = "fzf";
  };

  # Nushell-specific aliases that can't be shell aliases
  programs.nushell.extraConfig = ''
    # Aliases that need nushell syntax
    # alias cd = z
    # alias lf = yy

    # History search aliases
    # alias hs = history | where command =~ $in
    # alias hsi = history | where command =~ -i $in

    # Clipboard operations for command output
    # alias llty = eza -T | wl-copy
    # alias laty = eza -Ta | wl-copy

    # Core directory jumpers
    alias gd = z $"($env.HOME)/Downloads"
    alias gc = z $env.XDG_CONFIG_HOME
    alias gr = z $env.RHODIUM
    alias gp = z $env.HOME_PROJECTS
    alias ga = z $env.HOME_ACADEMIC
    alias gs = z $env.HOME_SOLENOIDLABS
    alias gpr = z $env.HOME_PROFESSIONAL
    alias gv = z $env.HOME_VAULTS
    alias gvs = z $env.HOME_VAULTS_SANCTUM

    # See utils
    # alias sa = alias | to text | fzf
    # alias sv = $env | to text | sort | fzf
  '';
}

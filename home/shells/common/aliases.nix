{ ... }:

{
  commonAliases = {
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
    tree = "eza -Ta";
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
    grep = "rga"; # ripgrep-all

    # Editor
    vim = "neovide";
    vi = "neovide";
    v = "neovide";

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
    neofetch = "disfetch";
    nf = "disfetch";
    "!!" = "sudo $history[1]";

    # Core Directories
    gd = "z $HOME_DOWNLOADS";
    gc = "z $XDG_CONFIG_HOME";
    gr = "z $RHODIUM";
    gp = "z $HOME_PROJECTS";
    ga = "z $HOME_ACADEMIC";
    gs = "z $HOME_SOLENOIDLABS";
    gpr = "z $HOME_PROFESSIONAL";
    gv = "z $HOME_VAULTS";
    gvs = "z $HOME_VAULTS_SANCTUM";

    # Fuzzy
    fzf = "fzf";
    fzd = "zi";
    fzh = "fzf-history-widget";

    # Git
    gst = "git status";
    gad = "git add .";
    gcm = "git commit -m";
    gpu = "git push -u origin main";
    grm = "git rm -r --cached .";

    # IDEs
    code = "code 2>/dev/null";
    # cursor = "cursor 2>/dev/null";

    # See-utils
    sa = "alias | fzf"; # See aliases
    sv = "env | sort | fzf"; # See environment vars
  };
}

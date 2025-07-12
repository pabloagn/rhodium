{
  editors = {
    editor-instance = {
      binary = "kitty";
      args = ["-e" "nvim"];
      icon = "nvim";
      description = "Editor";
    };
    helix-instance = {
      binary = "kitty";
      args = ["-e" "hx"];
      icon = "helix";
      description = "Helix";
    };
    nvim-instance = {
      binary = "kitty";
      args = ["-e" "nvim"];
      icon = "neovim";
      description = "Neovim";
    };
    zeditor = {
      binary = "zeditor";
      args = [];
      icon = "zeditor";
      description = "Zeditor";
    };
    code = {
      binary = "code";
      args = [];
      icon = "code";
      description = "VS Code";
    };
    emacs = {
      binary = "doom emacs";
      args = [];
      icon = "emacs";
      description = "Doom Emacs";
    };
    texmaker = {
      binary = "texmaker";
      args = [];
      icon = "texmaker";
      description = "Texmaker LaTeX Editor";
    };
    rstudio = {
      binary = "rstudio";
      args = [];
      icon = "rstudio";
      description = "RStudio IDE";
    };
  };

  viewers = {
    # image-viewer-xorg = {
    #   binary = "feh";
    #   args = ["-Z" "--scale-down" "--auto-zoom" "--image-bg" "black" "%f"];
    #   icon = "feh";
    #   description = "Image Viewer (X11)";
    # };
    image-viewer = {
      binary = "imv";
      args = [];
      icon = "imv";
      description = "Image Viewer (Wayland)";
    };
  };

  system = {
    bottom = {
      binary = "kitty";
      args = ["-e" "btm"];
      icon = "bottom";
      description = "Bottom (Htop)";
    };
    btop = {
      binary = "kitty";
      args = ["-e" "btop"];
      icon = "btop";
      description = "Btop Resource Monitor";
    };
  };

  productivity = {
    yazi = {
      binary = "kitty";
      args = ["-e" "yazi"];
      icon = "yazi";
      description = "Yazi in Kitty";
    };
    calcure = {
      binary = "kitty";
      args = ["-e" "calcure"];
      icon = "calcure";
      description = "Calcure Calendar and Tasks";
    };
    qalc = {
      binary = "kitty";
      args = ["-e" "qalc"];
      icon = "qalculate";
      description = "Qalculate CLI";
    };
    qalculate = {
      binary = "qalculate-gtk";
      args = [];
      icon = "qalculate";
      description = "Qalculate!";
    };
    qbittorrent = {
      binary = "qbittorrent";
      args = [];
      icon = "qbittorrent";
      description = "qBittorrent";
    };
    slack = {
      binary = "slack";
      args = [];
      icon = "slack";
      description = "Slack";
    };
    jitsimeet = {
      binary = "jitsi-meet";
      args = [];
      icon = "jitsi-meet";
      description = "Jitsi Meet";
    };
    zoomus = {
      binary = "zoom-us";
      args = [];
      icon = "zoom-us";
      description = "Zoom";
    };
    thunar = {
      binary = "thunar";
      args = [];
      icon = "thunar";
      description = "Thunar File Manager";
    };
    onepassword = {
      binary = "1password";
      # NOTE: Use flags below if not using xwayland-satellite
      # args = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];
      # NOTE: Use flag below if using xwayland-satellite > 0.6
      # args = ["--force-device-scale-factor=1.5"];
      # NOTE: Use no flags for latest beta release
      # NOTE: This is only possible with env var: ELECTRON_OZONE_PLATFORM_HINT = "auto";
      args = [];
      icon = "onepassword";
      description = "1Password";
    };
    bitwarden = {
      binary = "bitwarden";
      args = [];
      icon = "bitwarden";
      description = "Bitwarden";
    };
    # protonpassword = {
    #   binary = "proton-pass";
    #   args = [];
    #   icon = "proton";
    #   description = "ProtonPass";
    # };
    protonvpn = {
      binary = "protonvpn-app";
      args = [];
      icon = "proton";
      description = "ProtonVPN GUI";
    };
    protonmail = {
      binary = "proton-mail";
      args = [];
      icon = "protonmail";
      description = "ProtonMail";
    };
    libreofficewriter = {
      binary = "libreoffice";
      args = ["--writer"];
      icon = "libreoffice";
      description = "LibreOffice Writer";
    };
    libreofficecalc = {
      binary = "libreoffice";
      args = ["--calc"];
      icon = "libreoffice";
      description = "LibreOffice Calc";
    };
    libreofficedraw = {
      binary = "libreoffice";
      args = ["--draw"];
      icon = "libreoffice";
      description = "LibreOffice Draw";
    };
    libreofficeimpress = {
      binary = "libreoffice";
      args = ["--impress"];
      icon = "libreoffice";
      description = "LibreOffice Impress";
    };
    libreofficebase = {
      binary = "libreoffice";
      args = ["--base"];
      icon = "libreoffice";
      description = "LibreOffice Base";
    };
    libreofficeglobal = {
      binary = "libreoffice";
      args = ["--global"];
      icon = "libreoffice";
      description = "LibreOffice Global Document";
    };
    libreofficemath = {
      binary = "libreoffice";
      args = ["--math"];
      icon = "libreoffice";
      description = "LibreOffice Math";
    };
    libreofficeweb = {
      binary = "libreoffice";
      args = ["--web"];
      icon = "libreoffice";
      description = "LibreOffice HTML Document";
    };
    standardnotes = {
      binary = "standardnotes";
      # NOTE: The flags below are required to work outside X11 (e.g., niri)
      args = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];
      # NOTE: The flags below are required to work in hyprland
      # args = ["--force-device-scale-factor=1.5"];
      icon = "standardnotes";
      description = "Standard Notes";
    };
    teams = {
      binary = "teams-for-linux";
      args = [];
      icon = "teams";
      description = "Teams";
    };
    zen = {
      binary = "zen";
      args = [];
      icon = "zen";
      description = "Zen Browser";
    };
    obsidian = {
      binary = "obsidian";
      args = [];
      icon = "obsidian";
      description = "Obsidian";
    };
    brave = {
      binary = "brave";
      args = [""];
      icon = "brave";
      description = "Brave";
    };
    firefox-incognito = {
      binary = "firefox";
      args = ["-p" "Personal" "--private-window"];
      icon = "firefox";
      description = "Firefox Incognito";
    };
  };

  social = {
    signal-desktop = {
      binary = "signal-desktop";
      args = [];
      icon = "signal";
      description = "Signal Desktop";
    };
    telegram-desktop = {
      binary = "telegram-desktop";
      args = [];
      icon = "telegram";
      description = "Telegram Desktop";
    };
    discord = {
      binary = "discord";
      args = [];
      icon = "discord";
      description = "Discord";
    };
    discordo = {
      binary = "kitty";
      args = ["-e" "discordo"];
      icon = "discord";
      description = "Discord TUI";
    };
    element-call = {
      binary = "element-call";
      args = [];
      icon = "element";
      description = "Element Call (Matrix)";
    };
    fluffychat = {
      binary = "fluffychat";
      args = [];
      icon = "fluffychat";
      description = "Fluffychat (Matrix)";
    };
    mastodon = {
      binary = "mastodon";
      args = [];
      icon = "mastodon";
      description = "Mastodon Client";
    };
  };

  media = {
    spotify = {
      binary = "spotify";
      args = [];
      icon = "spotify";
      description = "Spotify GUI";
    };
    ncspot = {
      binary = "kitty";
      args = ["-e" "ncspot"];
      icon = "spotify";
      description = "Spotify TUI";
    };
    gimp = {
      binary = "gimp";
      args = [];
      icon = "gimp";
      description = "GIMP";
    };
    inkscape = {
      binary = "inkscape";
      args = [];
      icon = "inkscape";
      description = "InkScape";
    };
    obs = {
      binary = "obs";
      args = [];
      icon = "obs";
      description = "OBS Studio";
    };
  };

  terminals = {
    kitty-instance = {
      binary = "kitty";
      args = [];
      icon = "kitty";
      description = "Kitty";
    };
    foot-instance = {
      binary = "foot";
      args = [];
      icon = "foot";
      description = "Foot";
    };
    # alacritty-instance = {
    #   binary = "alacritty";
    #   args = [];
    #   icon = "alacritty";
    #   description = "Alacritty";
    # };
    ghostty-instance = {
      binary = "ghostty";
      args = [];
      icon = "ghostty";
      description = "Ghostty";
    };
  };

  shells = {
    bash-shell = {
      binary = "kitty";
      args = ["-e" "bash"];
      icon = "bash";
      description = "Bash Shell";
    };
    zsh-shell = {
      binary = "kitty";
      args = ["-e" "zsh"];
      icon = "zsh";
      description = "Zsh Shell";
    };
    fish-shell = {
      binary = "kitty";
      args = ["-e" "fish"];
      icon = "fish";
      description = "Fish Shell";
    };
    nu-shell = {
      binary = "kitty";
      args = ["-e" "nu"];
      icon = "nu";
      description = "Nu Shell";
    };
  };

  multiplexers = {
    tmux-session = {
      binary = "kitty";
      args = ["-e" "tmux"];
      icon = "tmux";
      description = "Tmux Session";
    };
    zellij = {
      binary = "kitty";
      args = ["-e" "zellij"];
      icon = "zellij";
      description = "Zellij Session";
    };
  };
}

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
    neovide-instance = {
      binary = "neovide";
      args = [];
      icon = "neovim";
      description = "Neovide";
    };
    zeditor-instance = {
      binary = "zeditor";
      args = [];
      icon = "zeditor";
      description = "Zeditor";
    };
    code-instance = {
      binary = "code";
      args = [];
      icon = "code";
      description = "VS Code";
    };
  };

  viewers = {
    image-viewer = {
      binary = "feh";
      args = ["-Z" "--scale-down" "--auto-zoom" "--image-bg" "black" "%f"];
      icon = "feh";
      description = "Image Viewer";
    };
  };

  productivity = {
    onepassword = {
      binary = "1password";
      # NOTE: The flags below are required to work outside X11 (e.g., niri)
      args = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];
      # NOTE: The flags below are required to work in hyprland
      # args = ["--force-device-scale-factor=1.5"];
      icon = "onepassword";
      description = "1Password";
    };
    protonmail = {
      binary = "proton-mail";
      args = [];
      icon = "protonmail";
      description = "ProtonMail";
    };
    slack = {
      binary = "slack";
      args = [];
      icon = "slack";
      description = "Slack";
    };
    standardnotes = {
      binary = "standardnotes";
      args = ["--force-device-scale-factor=1.5"];
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
    ghostty-instance = {
      binary = "ghostty";
      args = ["--shell-integration=none"];
      icon = "ghostty";
      description = "Ghostty";
    };
  };

  shells = {
    bash-shell = {
      binary = "ghostty";
      args = ["-e" "bash"];
      icon = "bash";
      description = "Bash Shell";
    };
    zsh-shell = {
      binary = "ghostty";
      args = ["-e" "zsh"];
      icon = "zsh";
      description = "Zsh Shell";
    };
    fish-shell = {
      binary = "ghostty";
      args = ["-e" "fish"];
      icon = "fish";
      description = "Fish Shell";
    };
    nu-shell = {
      binary = "ghostty";
      args = ["-e" "nu"];
      icon = "nu";
      description = "Nu Shell";
    };
  };

  multiplexers = {
    tmux-session = {
      binary = "ghostty";
      args = ["-e" "tmux"];
      icon = "tmux";
      description = "Tmux Session";
    };
    zellij = {
      binary = "ghostty";
      args = ["-e" "zellij"];
      icon = "zellij";
      description = "Zellij Session";
    };
  };
}

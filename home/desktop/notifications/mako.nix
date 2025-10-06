{ ... }:
let
  c = {
    # Normal
    color0 = "#0d0c0cff";
    color1 = "#c4746eff";
    color2 = "#8a9a7bff";
    color3 = "#c4b28aff";
    color4 = "#8ba4b0ff";
    color5 = "#a292a3ff";
    color6 = "#8ea4a2ff";
    color7 = "#C8C093ff";
    # Bright
    color8 = "#A4A7A4ff";
    color9 = "#E46876ff";
    color10 = "#87a987ff";
    color11 = "#E6C384ff";
    color12 = "#7FB4CAff";
    color13 = "#938AA9ff";
    color14 = "#7AA89Fff";
    color15 = "#C5C9C7ff";
    # Extended
    color16 = "#b6927bff";
    color17 = "#b98d7bff";
    color18 = "#678298ff";
    color19 = "#4a7fffff";
    color20 = "#59bfaaff";
    color21 = "#0d0d0dff";
    color22 = "#C24043ff";
    color23 = "#f2f2f2ff";
    color24 = "#2a2a2aff";
  };

  i = {
    icon01 = "◆";
  };

  notifTime = {
    xs = 1000;
    sm = 2000;
    md = 3000;
    lg = 4000;
    xl = 5000;
    xx = 10000;
  };

  iconSize = {
    xs = 12;
    sm = 24;
    md = 48;
    lg = 62;
    xl = 96;
    xx = 120;
  };
in
{
  services.mako = {
    enable = true;
    settings = {
      # --- Global Config ---
      max-history = 20;
      sort = "-time";

      # --- Style ---
      border-radius = 0;
      border-size = 1;
      font = "BerkeleyMonoRh Nerd Font 10";
      height = 120;
      margin = 10;
      outer-margin = 20;
      padding = "12,16";
      width = 400;
      progress-color = "over #5588AAFF";
      icons = 1;
      max-icon-size = iconSize.sm;
      icon-location = "left";
      markup = 1;
      actions = 1;
      history = 1;
      text-alignment = "left";
      default-timeout = notifTime.xx;

      ignore-timeout = 0;
      anchor = "top-right";
      layer = "top";

      # Bindings
      on-button-left = "invoke-default-action";
      on-button-middle = "dismiss";
      on-button-right = "dismiss-all";
      on-touch = "dismiss";
      # on-notify = "exec mpv /usr/share/sounds/freedesktop/stereo/message.oga --no-video --volume=50 2>/dev/null || true";

      # --- App Overrides ---
      # Messaging applications
      "app-name=Telegram" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◆ %s</b>\\n%b";
      };

      "app-name=discord" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◇ %s</b>\\n%b";
      };

      "app-name=vesktop" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◇ %s</b>\\n%b";
      };

      "desktop-entry=dev.vencord.Vesktop" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◇ %s</b>\\n%b";
      };

      "app-name=Signal" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>■ %s</b>\\n%b";
      };

      "app-name=niri" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      # --- System Notifications ---
      "app-name=notify-send" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>∴ System</b>\\n%b";
      };

      # --- Terminal Notifications ---
      "app-name=kitty" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=ghostty" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=foot" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=alacritty" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>λ %s</b>\\n%b";
      };

      # Bluetooth notifications
      "app-name=blueman" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>⊹ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      # Volume notifications
      "summary~=\"Volume\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>♪</b> %b";
        default-timeout = notifTime.md;
      };

      # Brightness notifications
      "summary~=\"Brightness\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>☀</b> %b";
        default-timeout = notifTime.md;
      };

      # Battery notifications
      "summary~=\"Battery\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◙ %s</b>\\n%b";
      };

      # Email notifications
      "app-name=thunderbird" = {
        background-color = "#262626FF";
        text-color = "${c.color23}";
        border-color = "#3c3c3cFF";
        format = "<b>⍋ %s</b>\\n%b";
      };

      # Download notifications
      "summary~=\"Download\"" = {
        background-color = "#1e1e1eFF";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>↓ %s</b>\\n%b";
      };

      # Security/Authentication
      "summary~=\"Authentication\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>⌺ %s</b>\\n%b";
        default-timeout = 0;
      };

      # USB/Device notifications
      "summary~=\"Device\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>▣ %s</b>\\n%b";
      };

      # Screenshot notifications
      "app-name=flameshot" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      "app-name=spectacle" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      # Git notifications
      "summary~=\"Git\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>⎇ %s</b>\\n%b";
      };

      # Build/Compilation notifications
      "summary~=\"Build\"" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>⚙ %s</b>\\n%b";
      };

      # Calendar/Schedule
      "app-name=gnome-calendar" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>◷ %s</b>\\n%b";
      };

      # Music players
      "app-name=Spotify" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>⊹ %s</b>\\n%b";
        default-timeout = notifTime.xl;
      };

      "app-name=rhythmbox" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>♩ %s</b>\\n%b";
        default-timeout = notifTime.xl;
      };

      # File manager
      "app-name=nautilus" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>▤ %s</b>\\n%b";
      };

      "app-name=thunar" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "${c.color24}";
        format = "<b>▤ %s</b>\\n%b";
      };

      # --- Grouped Notifications ---
      grouped = {
        format = "<b>∑ (%g) %s</b>\\n%b";
      };

      # --- Mode Configurations ---
      "mode=do-not-disturb" = {
        invisible = 1;
      };

      "mode=minimal" = {
        format = "%s";
        border-size = 0;
        padding = 8;
      };

      # --- Custom Applications ---
      "desktop-entry=org.freedesktop.network-manager-applet" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      "app-name=rh-util-screen-annotate" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      "app-name=rh-util-screen-ocr" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
        # on-button-left = "kitty --directory $HOME/pictures/ocr -e yazi";
      };

      "app-name=rh-util-opacity" = {
        background-color = "${c.color21}";
        text-color = "${c.color23}";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = notifTime.md;
      };

      "app-name=rh-util-kill" = {
        background-color = "${c.color21}";
        text-color = "${c.color22}";
        border-color = "${c.color22}";
        format = "<b>🗡 %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      # --- Fuzzels ---
      "app-name=rh-fuzzel-apps" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>λ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-auth" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>α %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-bluetooth" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>β %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-colors" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>γ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-display" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>δ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-emoji" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ε %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-find" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>󰊕 %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-go" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Γ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-help" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Π %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-icons" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>∪ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-journals" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Φ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-kill" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ψ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-launch" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Λ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-mounts" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>∩ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-networking" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>η %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-power" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Ω %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-query" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ο %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-remote" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ρ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-services" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>σ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-temperature" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Δ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-usb" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>μ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-vaults" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>π %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-wifi" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ω %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-xecute" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ξ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-yank" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Ξ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      "app-name=rh-fuzzel-zutils" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ζ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      # --- Rhodium Builds ---
      "app-name=rh-build" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>λ %s</b>\\n%b";
        default-timeout = notifTime.lg;
      };

      # NOTE:
      # All these override my entire setup.
      # They're forbidden and should never be used.
      # --- Urgency Styling ---
      # Low priority
      # "urgency=low" = {
      #   background-color = "#1a1a1aFF";
      #   text-color = "#888888FF";
      #   border-color = "#2a2a2aFF";
      #   format = "<b>─ %s</b>\\n%b";
      #   default-timeout = 8000;
      # };
      #
      # # Normal priority
      # "urgency=normal" = {
      #   background-color = "#2a2a2aFF";
      #   text-color = "${c.color23}";
      #   border-color = "#3c3c3cFF";
      #   format = "<b>▶ %s</b>\\n%b";
      #   default-timeout = 10000;
      # };
      #
      # # Critical priority
      # "urgency=critical" = {
      #   background-color = "#3a3a3aFF";
      #   text-color = "${c.color23}";
      #   border-color = "#555555FF";
      #   format = "<b>▓ %s ▓</b>\\n%b";
      #   default-timeout = 0;
      # };

      # # --- Default Format ---
      # format = "<b>⊹ %s</b>\\n%b";
      # background-color = "#2a2a2aFF";
      # border-color = "#3c3c3cFF";
      # text-color = "${c.color23}";
    };
  };
}

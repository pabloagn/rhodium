{...}: let
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
    color18 = "#4B5F6Fff";
    color19 = "#4a7fffff";
    color20 = "#59bfaaff";
    color21 = "#0d0d0dff";
    color22 = "#C24043ff";
  };

  i = {
    icon01 = "◆";
  };
in let
  viaColor = c.color18;
  colors = c;
in {
  services.mako = {
    enable = true;
    settings = {
      # --- Global Config ---
      max-history = 20;
      sort = "-time";

      # --- Style ---
      background-color = "#2a2a2aFF";
      border-color = "#3c3c3cFF";
      border-radius = 0;
      border-size = 1;
      font = "BerkeleyMonoRh Nerd Font";
      height = 120;
      margin = 10;
      outer-margin = 20;
      padding = "12,16";
      text-color = "#ffffffFF";
      width = 400;
      progress-color = "over #5588AAFF";
      icons = 1;
      max-icon-size = 48;
      icon-location = "left";
      markup = 1;
      actions = 1;
      history = 1;

      # Default format
      format = "<b>⊹ %s</b>\\n%b";
      text-alignment = "left";
      default-timeout = 10000;

      ignore-timeout = 0;
      anchor = "top-right";
      layer = "top";

      # Bindings
      on-button-left = "invoke-default-action";
      on-button-middle = "dismiss";
      on-button-right = "dismiss-all";
      on-touch = "dismiss";
      on-notify = "exec mpv /usr/share/sounds/freedesktop/stereo/message.oga --no-video --volume=50 2>/dev/null || true";

      # --- Urgency Styling ---
      # Low priority - subdued presence
      "urgency=low" = {
        background-color = "#1a1a1aFF";
        text-color = "#888888FF";
        border-color = "#2a2a2aFF";
        format = "<b>─ %s</b>\\n%b";
        default-timeout = 8000;
      };

      # Normal priority - standard interface
      "urgency=normal" = {
        background-color = "#2a2a2aFF";
        text-color = "#ffffffFF";
        border-color = "#3c3c3cFF";
        format = "<b>▶ %s</b>\\n%b";
        default-timeout = 10000;
      };

      # Critical priority - demanding attention
      "urgency=critical" = {
        background-color = "#3a3a3aFF";
        text-color = "#ffffffFF";
        border-color = "#555555FF";
        format = "<b>▓ %s ▓</b>\\n%b";
        default-timeout = 0;
      };

      # --- App Overrides ---
      # Messaging applications
      "app-name=Telegram" = {
        background-color = "#1e1e1eFF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>◆ %s</b>\\n%b";
      };

      "app-name=discord" = {
        background-color = "#1e1e1eFF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>◇ %s</b>\\n%b";
      };

      "app-name=Signal" = {
        background-color = "#1e1e1eFF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>■ %s</b>\\n%b";
      };

      # --- System Notifications ---
      "app-name=notify-send" = {
        background-color = "#262626FF";
        text-color = "#ffffffFF";
        border-color = "#404040FF";
        format = "<b>∴ SYSTEM</b>\\n%b";
      };

      # --- Terminal Notifications ---
      "app-name=kitty" = {
        background-color = "#1a1a1aFF";
        text-color = "#ffffffFF";
        border-color = "#333333FF";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=ghostty" = {
        background-color = "#1a1a1aFF";
        text-color = "#ffffffFF";
        border-color = "#333333FF";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=foot" = {
        background-color = "#1a1a1aFF";
        text-color = "#ffffffFF";
        border-color = "#333333FF";
        format = "<b>λ %s</b>\\n%b";
      };

      "app-name=alacritty" = {
        background-color = "#1a1a1aFF";
        text-color = "#ffffffFF";
        border-color = "#333333FF";
        format = "<b>λ %s</b>\\n%b";
      };

      # Volume notifications
      "summary~=\"Volume\"" = {
        background-color = "#1a1a1aFF";
        text-color = "#aaaaaaFF";
        border-color = "#2a2a2aFF";
        format = "<b>♪</b> %b";
        default-timeout = 3000;
      };

      # Brightness notifications
      "summary~=\"Brightness\"" = {
        background-color = "#1a1a1aFF";
        text-color = "#aaaaaaFF";
        border-color = "#2a2a2aFF";
        format = "<b>☀</b> %b";
        default-timeout = 3000;
      };

      # Battery notifications
      "summary~=\"Battery\"" = {
        background-color = "#1a1a1aFF";
        text-color = "#ffffffFF";
        border-color = "#2a2a2aFF";
        format = "<b>◙ %s</b>\\n%b";
      };

      # Network notifications
      "summary~=\"Network\"" = {
        background-color = "#222222FF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>⌽ %s</b>\\n%b";
      };

      "summary~=\"Wi-Fi\"" = {
        background-color = "#222222FF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>⌽ %s</b>\\n%b";
      };

      # Email notifications
      "app-name=thunderbird" = {
        background-color = "#262626FF";
        text-color = "#ffffffFF";
        border-color = "#3c3c3cFF";
        format = "<b>⍋ %s</b>\\n%b";
      };

      # Download notifications
      "summary~=\"Download\"" = {
        background-color = "#1e1e1eFF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>↓ %s</b>\\n%b";
      };

      # Security/Authentication
      "summary~=\"Authentication\"" = {
        background-color = "#2a2a2aFF";
        text-color = "#ffffffFF";
        border-color = "#555555FF";
        format = "<b>⌺ %s</b>\\n%b";
        default-timeout = 0;
      };

      # USB/Device notifications
      "summary~=\"Device\"" = {
        background-color = "#222222FF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>▣ %s</b>\\n%b";
      };

      # Screenshot notifications
      "app-name=flameshot" = {
        background-color = "#1a1a1aFF";
        text-color = "#aaaaaaFF";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = 3000;
      };

      "app-name=spectacle" = {
        background-color = "#1a1a1aFF";
        text-color = "#aaaaaaFF";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = 3000;
      };

      # Git notifications
      "summary~=\"Git\"" = {
        background-color = "#222222FF";
        text-color = "#ffffffFF";
        border-color = "#3c3c3cFF";
        format = "<b>⎇ %s</b>\\n%b";
      };

      # Build/Compilation notifications
      "summary~=\"Build\"" = {
        background-color = "#262626FF";
        text-color = "#ffffffFF";
        border-color = "#404040FF";
        format = "<b>⚙ %s</b>\\n%b";
      };

      # Calendar/Schedule
      "app-name=gnome-calendar" = {
        background-color = "#2a2a2aFF";
        text-color = "#ffffffFF";
        border-color = "#444444FF";
        format = "<b>◷ %s</b>\\n%b";
      };

      # Music players
      "app-name=Spotify" = {
        background-color = "#1a1a1aFF";
        text-color = "#ccccccFF";
        border-color = "#2a2a2aFF";
        # format = "<b>♫ %s</b>\\n%b";
        default-timeout = 5000;
      };

      "app-name=rhythmbox" = {
        background-color = "#1a1a1aFF";
        text-color = "#ccccccFF";
        border-color = "#2a2a2aFF";
        format = "<b>♫ %s</b>\\n%b";
        default-timeout = 5000;
      };

      # File manager
      "app-name=nautilus" = {
        background-color = "#222222FF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>▤ %s</b>\\n%b";
      };

      "app-name=thunar" = {
        background-color = "#222222FF";
        text-color = "#ccccccFF";
        border-color = "#333333FF";
        format = "<b>▤ %s</b>\\n%b";
      };

      # GROUPED NOTIFICATIONS
      grouped = {
        format = "<b>∑ (%g) %s</b>\\n%b";
      };

      # Mode configurations
      "mode=do-not-disturb" = {
        invisible = 1;
      };

      "mode=minimal" = {
        format = "%s";
        border-size = 0;
        padding = 8;
      };

      # --- Custom Applications ---
      "app-name=rh-util-screen-anotate" = {
        background-color = "#1a1a1aFF";
        text-color = "#aaaaaaFF";
        border-color = "#2a2a2aFF";
        format = "<b>◌ %s</b>\\n%b";
        default-timeout = 3000;
      };

      "app-name=rh-util-kill" = {
        background-color = "${c.color21}";
        text-color = "${c.color22}";
        border-color = "${c.color22}";
        format = "<b>🗡 %s</b>\\n%b";
        default-timeout = 4000;
      };

      # --- Fuzzels ---
      "app-name=rh-apps" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>λ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-auth" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>α %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-bluetooth" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>β %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-colors" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>γ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-display" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>δ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-emoji" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ε %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-find" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ƒ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-git" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ϱ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-help" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Π %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-unicode" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Ι %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-journals" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ͳ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-launch" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Λ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-mounts" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Μ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-power" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Ω %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-services" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Σ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-color-temp" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ψ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-wifi" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ω %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-xperiments" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>Ξ %s</b>\\n%b";
        default-timeout = 4000;
      };

      "app-name=rh-z" = {
        background-color = "${c.color21}";
        text-color = "${c.color18}";
        border-color = "${c.color18}";
        format = "<b>ζ %s</b>\\n%b";
        default-timeout = 4000;
      };
    };
  };

  # xdg.configFile."mako/config" = {
  #   source = ./mako/config;
  #   force = true;
  # };
}

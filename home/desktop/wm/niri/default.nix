{
  lib,
  host,
  ...
}:

let
  # Helper to convert string to float (ensures float type even for integer strings)
  toFloat = str: (builtins.fromJSON str) * 1.0;

  # Extract host display configuration
  hostname = host.hostname or "unknown";

  # Main monitor configuration from host data
  mainMonitor =
    host.mainMonitor or {
      monitorID = "eDP-1";
      monitorResolution = "1920x1080";
      monitorRefreshRate = "60";
      monitorScalingFactor = "1.0";
    };

  # Parse resolution to get width and height
  parseResolution =
    resolution:
    let
      parts = lib.splitString "x" resolution;
    in
    {
      width = if (builtins.length parts) >= 1 then lib.toInt (builtins.elemAt parts 0) else 1920;
      height = if (builtins.length parts) >= 2 then lib.toInt (builtins.elemAt parts 1) else 1080;
    };

  resolution = parseResolution mainMonitor.monitorResolution;
  refreshRate = toFloat mainMonitor.monitorRefreshRate;
  scaleFactor = toFloat mainMonitor.monitorScalingFactor;

  # Calculate HDMI position based on main monitor settings
  # Position = main_width / main_scale (logical pixels)
  hdmiPositionX = builtins.floor (resolution.width / scaleFactor);
in
{
  programs.niri.settings = {
    # ============================================================================
    # Environment
    # ============================================================================
    # Required for xwayland-satellite X11 app compatibility
    environment = {
      DISPLAY = ":0";
    };

    # ============================================================================
    # Input
    # ============================================================================
    input = {
      keyboard = {
        xkb = {
          layout = "us,gb,es";
          options = "grp:win_space_toggle";
        };
        repeat-delay = 300;
        repeat-rate = 90;
        numlock = true;
      };

      touchpad = {
        dwt = true;
        dwtp = true;
        tap = true;
        natural-scroll = false;
        accel-speed = -0.3;
        middle-emulation = true;
        scroll-factor = 1.0;
        drag = true;
      };

      mouse = {
        accel-speed = 0.1;
        accel-profile = "adaptive";
        scroll-factor = 0.9;
        middle-emulation = true;
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "90%";
      };

      workspace-auto-back-and-forth = true;
    };

    # ============================================================================
    # Outputs
    # ============================================================================
    outputs = {
      # Main laptop display (dynamic based on host)
      "${mainMonitor.monitorID}" = {
        mode = {
          width = resolution.width;
          height = resolution.height;
          refresh = refreshRate;
        };
        scale = scaleFactor;
        position = {
          x = 0;
          y = 0;
        };
      };

      # External HDMI display (same config for both hosts)
      "HDMI-A-1" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 60.0;
        };
        scale = 1.5;
        position = {
          x = hdmiPositionX;
          y = 0;
        };
      };
    };

    # ============================================================================
    # Layer Rules
    # ============================================================================
    layer-rules = [
      {
        matches = [ { namespace = "^wallpaper$"; } ];
        place-within-backdrop = true;
      }
      {
        matches = [ { namespace = "^launcher"; } ];
        shadow = {
          enable = true;
          softness = 40;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000050";
        };
      }
    ];

    # ============================================================================
    # Window Rules
    # ============================================================================
    window-rules = [
      # Calculator apps
      {
        matches = [ { app-id = "qalculate-gtk"; } ];
        open-maximized = true;
      }
      {
        matches = [ { app-id = "calcure"; } ];
        open-maximized = true;
      }

      # Television launcher
      {
        matches = [ { app-id = "television-launcher"; } ];
        default-column-width = { proportion = 0.8; };
        open-floating = true;
        default-window-height = { fixed = 700; };
        focus-ring = {
          enable = true;
          width = 1;
          active = {
            gradient = {
              from = "#E46876";
              to = "#c4746e";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
          inactive = {
            gradient = {
              from = "#505050";
              to = "#808080";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
        };
        shadow = {
          enable = true;
          softness = 40;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000050";
        };
      }
      {
        matches = [ { title = "Television Picker"; } ];
        default-column-width = { proportion = 0.8; };
        open-floating = true;
        default-window-height = { fixed = 700; };
        focus-ring = {
          enable = true;
          width = 1;
          active = {
            gradient = {
              from = "#E46876";
              to = "#c4746e";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
          inactive = {
            gradient = {
              from = "#505050";
              to = "#808080";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
        };
        shadow = {
          enable = true;
          softness = 40;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000050";
        };
      }

      # Global transparency
      {
        matches = [ { is-active = true; } ];
        opacity = 0.98;
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.98;
      }

      # Wezterm CSD handling
      {
        matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
      }

      # Firefox Picture-in-Picture
      {
        matches = [
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
    ];

    # ============================================================================
    # General Settings
    # ============================================================================
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;

    cursor = {
      size = 24;
      hide-after-inactive-ms = 2000;
    };

    # ============================================================================
    # Gestures
    # ============================================================================
    gestures = {
      dnd-edge-view-scroll = {
        trigger-width = 30;
        delay-ms = 100;
        max-speed = 1500;
      };
      dnd-edge-workspace-switch = {
        trigger-height = 50;
        delay-ms = 100;
        max-speed = 1500;
      };
      hot-corners.enable = false;
    };

    # ============================================================================
    # Overview
    # ============================================================================
    overview = {
      zoom = 0.6;
      workspace-shadow.enable = false;
    };

    # ============================================================================
    # Layout
    # ============================================================================
    layout = {
      shadow = {
        softness = 10;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        draw-behind-window = false;
        color = "#090D1270";
        inactive-color = "#00000054";
      };

      background-color = "transparent";
      gaps = 12;
      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 1.0; }
      ];

      default-column-width = { proportion = 0.5; };

      preset-window-heights = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 1.0; }
        { fixed = 720; }
      ];

      focus-ring = {
        enable = false;
        width = 1;
        active = {
          color = "rgb(255 200 127)";
        };
        inactive = {
          color = "rgb(80 80 80)";
        };
      };

      border = {
        enable = false;
        width = 1;
        active = {
          gradient = {
            from = "#090E13";
            to = "#C14043";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          color = "#090D12";
        };
      };

      tab-indicator = {
        place-within-column = true;
        gap = 5;
        width = 4;
        length = { total-proportion = 1.0; };
        position = "left";
        gaps-between-tabs = 2;
        corner-radius = 0;
        active = {
          gradient = {
            from = "#c4b28a";
            to = "#c4746e";
            angle = 45;
          };
        };
        inactive = {
          gradient = {
            from = "#0d0c0c";
            to = "#808080";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        urgent = {
          gradient = {
            from = "#E46876";
            to = "#c4746e";
            angle = 45;
          };
        };
      };
    };

    # ============================================================================
    # Startup Programs
    # ============================================================================
    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
      { command = [ "sh" "-c" "~/.local/bin/fuzzel-polkit.sh" ]; }
    ];

    # ============================================================================
    # Animations
    # ============================================================================
    animations = {
      slowdown = 0.8;

      window-open.kind.easing = {
        duration-ms = 150;
        curve = "ease-out-expo";
      };

      window-close.kind.easing = {
        duration-ms = 150;
        curve = "ease-out-quad";
      };

      horizontal-view-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };

      window-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };

      window-resize.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };

      config-notification-open-close.kind.spring = {
        damping-ratio = 0.6;
        stiffness = 1000;
        epsilon = 0.001;
      };

      screenshot-ui-open.kind.easing = {
        duration-ms = 200;
        curve = "ease-out-quad";
      };

      overview-open-close.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };

    # ============================================================================
    # Screenshot
    # ============================================================================
    screenshot-path = "~/pictures/screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";

    # ============================================================================
    # Keybindings
    # ============================================================================
    binds = {
      # System & Core Controls
      "Mod+Escape".action.spawn = "hyprlock";

      # Focus Navigation
      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+Up".action.focus-window-up = [ ];
      "Mod+Down".action.focus-window-down = [ ];
      "Mod+H".action.focus-column-left = [ ];
      "Mod+L".action.focus-column-right = [ ];
      "Mod+K".action.focus-window-up = [ ];
      "Mod+J".action.focus-window-down = [ ];
      "Mod+Tab".action.focus-workspace-previous = [ ];
      "Alt+Tab".action.focus-window-previous = [ ];

      # Window & Column Manipulation
      "Mod+C".action.close-window = [ ];
      "Mod+Ctrl+C".action.spawn = [ "sh" "-c" "$USERBIN_UTILS/utils-kill.sh" ];
      "Mod+Ctrl+O".action.spawn = [ "sh" "-c" "$USERBIN_UTILS/utils-opacity.sh" ];
      "Mod+V".action.toggle-window-floating = [ ];
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
      "Mod+Comma".action.consume-or-expel-window-left = [ ];
      "Mod+Period".action.consume-or-expel-window-right = [ ];

      # Move Column
      "Mod+Ctrl+Left".action.move-column-left = [ ];
      "Mod+Ctrl+Right".action.move-column-right = [ ];
      "Mod+Ctrl+Down".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+Up".action.move-column-to-workspace-up = [ ];
      "Mod+Ctrl+H".action.move-column-left = [ ];
      "Mod+Ctrl+L".action.move-column-right = [ ];
      "Mod+Ctrl+J".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+K".action.move-column-to-workspace-up = [ ];

      # Move Window
      "Mod+Ctrl+S".action.move-window-up-or-to-workspace-up = [ ];
      "Mod+Ctrl+A".action.move-window-down-or-to-workspace-down = [ ];

      # Maximize & Resize
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Z".action.toggle-column-tabbed-display = [ ];
      "Mod+Shift+C".action.center-column = [ ];
      "Mod+R".action.switch-preset-column-width = [ ];
      "Mod+Shift+R".action.switch-preset-window-height = [ ];
      "Mod+Ctrl+R".action.reset-window-height = [ ];
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Workspace Navigation (Dynamic)
      "Mod+Alt+Up".action.move-workspace-up = [ ];
      "Mod+Alt+Down".action.move-workspace-down = [ ];
      "Mod+Shift+Up".action.focus-workspace-up = [ ];
      "Mod+Shift+Down".action.focus-workspace-down = [ ];

      # Workspace Navigation (Numeric)
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+0".action.focus-workspace = 10;

      # Move to Workspace (Numeric)
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;
      "Mod+Shift+0".action.move-column-to-workspace = 10;

      # Application Launchers (Primary)
      "Mod+W".action.spawn = "kitty";
      "Mod+B".action.spawn = [ "firefox" "-p" "Personal" ];
      "Mod+D".action.spawn = [ "kitty" "-e" "yazi" ];
      "Mod+E".action.spawn = [ "kitty" "-e" "nvim" ];
      "Mod+Q".action.spawn = [ "sh" "-c" "$USERBIN_LAUNCHERS/launchers-qalc.sh" ];

      # Application Launchers (Secondary - Shift)
      "Mod+Shift+W".action.spawn = "ghostty";
      "Mod+Shift+B".action.spawn = "brave";
      "Mod+Shift+D".action.spawn = "thunar";
      "Mod+Shift+E".action.spawn = [ "emacsclient" "-c" ];
      "Mod+Shift+Q".action.spawn = [ "sh" "-c" "$USERBIN_LAUNCHERS/launchers-qalculate.sh" ];

      # Application Launchers (Tertiary - Ctrl)
      "Mod+Ctrl+Q".action.spawn = [ "sh" "-c" "$USERBIN_LAUNCHERS/launchers-calcure.sh" ];
      "Mod+Ctrl+E".action.spawn = "zeditor";

      # Screenshots
      "Mod+S".action.screenshot-screen = [ ];
      "Print".action.screenshot-screen = [ ];
      "Mod+Shift+S".action.screenshot = [ ];
      "Shift+Print".action.screenshot = [ ];
      "Mod+Alt+S".action.screenshot-window = [ ];
      "Ctrl+Print".action.screenshot-window = [ ];
      "Mod+A".action.spawn = [ "sh" "-c" "$USERBIN_UTILS/utils-screenshot-annotate.sh" ];
      "Alt+Print".action.spawn = [ "sh" "-c" "$USERBIN_UTILS/utils-screenshot-annotate.sh" ];
      "Mod+Shift+A".action.spawn = [ "sh" "-c" "$USERBIN_UTILS/utils-ocr.sh" ];

      # Mouse & Trackpad Scroll Bindings
      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = [ ];
        cooldown-ms = 50;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = [ ];
        cooldown-ms = 50;
      };
      "Mod+WheelScrollRight" = {
        action.focus-column-right = [ ];
        cooldown-ms = 100;
      };
      "Mod+WheelScrollLeft" = {
        action.focus-column-left = [ ];
        cooldown-ms = 100;
      };
      "Mod+TouchpadScrollUp".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+" ];
      "Mod+TouchpadScrollDown".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-" ];

      # Multimedia & Hardware Controls
      "XF86AudioRaiseVolume" = {
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessUp" = {
        action.spawn = [ "brightnessctl" "set" "+5%" ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action.spawn = [ "brightnessctl" "set" "5%-" ];
        allow-when-locked = true;
      };
      "XF86AudioPlay" = {
        action.spawn = [ "playerctl" "play-pause" ];
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action.spawn = [ "playerctl" "next" ];
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action.spawn = [ "playerctl" "previous" ];
        allow-when-locked = true;
      };

      # Overview
      "Mod+X" = {
        action.toggle-overview = [ ];
        repeat = false;
      };
    };
  };
}

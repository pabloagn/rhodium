{config, ...}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      margin-left = 12;
      margin-right = 12;
      margin-top = 10;
      margin-bottom = 0;
      spacing = 1;
      reload_style_on_change = true;

      # Order of modules
      modules-left = [
        # "custom/rhodium"
        "niri/workspaces"
      ];
      modules-center = ["clock"];
      modules-right = [
        "network"
        "niri/language"
        "keyboard-state#capslock"
        "battery"
        "cpu"
        "memory"
        "disk"
        "temperature"
        "backlight"
        # "custom/display-temp"
        "wireplumber"
        "bluetooth"
      ];

      "custom/rhodium" = {
        format = "Rh";
        tooltip = false;
        on-click = "fuzzel";
        on-click-right = "fuzzel";
      };

      # Num Lock
      "keyboard-state#numlock" = {
        numlock = true;
        capslock = false;
        scrolllock = false;
        format = "N [{icon}]";
        format-icons = {
          locked = "⌽";
          unlocked = "○";
        };
      };

      # Caps Lock
      "keyboard-state#capslock" = {
        numlock = false;
        capslock = true;
        scrolllock = false;
        format = "C [{icon}]";
        format-icons = {
          locked = "⌽";
          unlocked = "○";
        };
      };

      # Niri workspace module
      "niri/workspaces" = {
        format = "●";
        on-click = "activate";
      };

      # Niri keyboard layout indicator
      "niri/language" = {
        format = " {short} ◆";
        on-click = "${config.home.homeDirectory}/.local/bin/utils/utils-switchkeyboard.sh";
      };

      clock = {
        interval = 1;
        format = "{:%H.%M.%S}";
        format-alt = "{:%A, %B %d, %Y [%R]} ";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#E6C384'><b>{}</b></span>";
            days = "<span color='#C5C9C7'><b>{}</b></span>";
            weeks = "<span color='#7AA89F'><b>W{}</b></span>";
            weekdays = "<span color='#c4b28a'><b>{}</b></span>";
            today = "<span color='#E46876'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-left = "kitty -e calcure";
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      temperature = {
        critical-threshold = 80;
        interval = 1;
        format = "{temperatureC}°C ☀";
        format-icons = ["" "" ""];
        on-click = "${config.home.homeDirectory}/.local/bin/lanchers/launchers-btop.sh";
      };

      cpu = {
        interval = 1;
        format = "⚙ {usage}% {icon}";
        format-icons = [
          "[⠀]"
          "[⢀]"
          "[⣀]"
          "[⣠]"
          "[⣤]"
          "[⣴]"
          "[⣶]"
          "[⣾]"
          "[⣿]"
        ];
        tooltip = true;
        tooltip-format = "CPU Usage ⟶ {usage}%\nLoad Average ⟶ {load}\nAvg Frequency ⟶ {avg_frequency}GHz\nMax Frequency ⟶ {max_frequency}GHz\nMin Frequency ⟶ {min_frequency}GHz\n\nCore 0 ⟶ {usage0}% {icon0}\nCore 1 ⟶ {usage1}%";
        on-click = "${config.home.homeDirectory}/.local/bin/lanchers/launchers-btop.sh";
      };

      memory = {
        interval = 2;
        format = "𝍖 {}% {icon}";
        format-icons = [
          "[⠀]"
          "[⢀]"
          "[⣀]"
          "[⣠]"
          "[⣤]"
          "[⣴]"
          "[⣶]"
          "[⣾]"
          "[⣿]"
        ];
        tooltip = true;
        on-click = "${config.home.homeDirectory}/.local/bin/lanchers/launchers-btop.sh";
      };

      disk = {
        interval = 15;
        format = "{percentage_used}% ⬢";
        tooltip = true;
        on-click = "${config.home.homeDirectory}/.local/bin/lanchers/launchers-btop.sh";
      };

      backlight = {
        format = "{percent}% {icon}";
        format-icons = ["○" "◐" "●"];
      };

      network = {
        interval = 1;
        format-wifi = "{bandwidthDownBytes:>} ↓";
        format-ethernet = "{bandwidthDownBytes:>} ↓";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ⟶ {frequency}MHz\n{ipaddr}/{cidr} ⟶ {gwaddr}\n{bandwidthUpBytes:>} ↑ {bandwidthDownBytes:>} ↓\n{signaldBm}dBm [{bssid}]";
        tooltip-format-ethernet = "{ifname} ⟶ {ipaddr}/{cidr}\nGateway: {gwaddr}\n{bandwidthUpBytes:>} ↑ {bandwidthDownBytes:>} ↓";
        tooltip-format-linked = "{ifname} ⟶ No IP\nInterface linked but no address";
        tooltip-format-disconnected = "Network disconnected ⌽\nNo active connection";
        format-linked = "No IP";
        format-disconnected = "⌽";
        on-click = "${config.home.homeDirectory}/.local/bin/fuzzel/fuzzel-wifi.sh";
        on-click-right = "nm-connection-editor";
      };

      bluetooth = {
        format = "{num_connections} {status}";
        format-disabled = "0 [⌽]";
        format-off = "0 [▼]";
        format-on = "0 [△]";
        format-connected = "{num_connections} [▲]";
        tooltip = true;
        tooltip-format = "{controller_alias} ⟶ {controller_address}\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias} ⟶ {controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "↳ {device_alias} [{device_address}]";
        tooltip-format-enumerate-connected-battery = "↳ {device_alias} [{device_address}] ⦚ {device_battery_percentage}%";
        on-click = "${config.home.homeDirectory}/.local/bin/fuzzel/fuzzel-bluetooth.sh";
        on-click-right = "blueman-manager";
      };

      wireplumber = {
        format = "{volume}% {icon}";
        format-muted = "{volume}% [⌽]";
        format-icons = ["[-]" "[=]" "[≡]"];
        on-click = "pavucontrol";
        states = {
          warning = 75;
          critical = 100;
        };
      };

      battery = {
        interval = 5;
        bat = "BAT1";
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        on-click = "${config.home.homeDirectory}/.local/bin/fuzzel/fuzzel-power.sh";
        on-click-right = "${config.home.homeDirectory}/.local/bin/lanchers/launchers-btop.sh";
        format = "Ω {capacity}% {icon}";
        format-charging = "{capacity}% ↯";
        format-plugged = "{capacity}% ↯";
        format-icons = [
          "[⠀]"
          "[⢀]"
          "[⣀]"
          "[⣠]"
          "[⣤]"
          "[⣴]"
          "[⣶]"
          "[⣾]"
          "[⣿]"
        ];
        tooltip = true;
        tooltip-format = "Battery ⟶ {capacity}%\nPower Draw ⟶ {power}W\nTime Remaining ⟶ {time}\nHealth ⟶ {health}%\nCharge Cycles ⟶ {cycles}";
        tooltip-format-charging = "Battery ⟶ {capacity}% [↯ Charging]\nPower Input ⟶ {power}W\nTime to Full ⟶ {time}\nHealth ⟶ {health}%\nCharge Cycles ⟶ {cycles}";
        tooltip-format-plugged = "Battery ⟶ {capacity}% [↯ Plugged]\nPower Draw ⟶ {power}W\nHealth ⟶ {health}%\nCharge Cycles ⟶ {cycles}";
        tooltip-format-full = "Battery ⟶ {capacity}% [● Full]\nPower Draw ⟶ {power}W\nHealth ⟶ {health}%\nCharge Cycles ⟶ {cycles}";
      };
    };
  };
}

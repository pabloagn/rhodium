# home/desktop/bar/waybar.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.bar.waybar;

  waybarSettings = {
    layer = "top";
    position = "top";
    height = 35;
    "margin-left" = 12;
    "margin-right" = 12;
    "margin-top" = 10;
    "margin-bottom" = 0;
    spacing = 1;
    reload_style_on_change = true;

    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [
      "network"
      "hyprland/language"
      "battery"
      "cpu"
      "memory"
      "disk"
      "temperature"
      "backlight"
      "wireplumber"
      "tray"
    ];

    "hyprland/workspaces" = {
      "on-click" = "activate";
      "all-outputs" = true;
      format = "{icon}";
      "format-icons" = {
        "1" = "I";
        "2" = "II";
        "3" = "III";
        "4" = "IV";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VII";
        "9" = "IX";
        "10" = "X";
        "11" = "XI";
        "12" = "XII";
        "13" = "XIII";
        "14" = "XIV";
        "15" = "XV";
        "16" = "XVI";
        "17" = "XVII";
        "18" = "XVIII";
        "19" = "XIX";
        "20" = "XX";
      };
    };

    tray = {
      "icon-size" = 18;
      spacing = 5;
      "show-passive-items" = true;
    };

    clock = {
      interval = 60;
      format = "  {:%a %b %d  %I:%M %p}";
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      "format-alt" = "{:%Y-%m-%d}";
    };

    temperature = {
      "critical-threshold" = 80;
      interval = 2;
      format = "{temperatureC}°C ";
      "format-icons" = [ "" "" "" ];
      "on-click" = "hyprctl dispatcher togglespecialworkspace monitor";
    };

    cpu = {
      interval = 2;
      format = "{usage}% ";
      tooltip = false;
      "on-click" = "hyprctl dispatcher togglespecialworkspace monitor";
    };

    memory = {
      interval = 2;
      format = "{}% ";
    };

    disk = {
      interval = 15;
      format = "{percentage_used}%  ";
    };

    backlight = {
      format = "{percent}% {icon}";
      "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
    };

    "hyprland/language" = {
      format = "  {}";
      "format-en" = "EN";
      "format-es" = "ES";
    };

    network = {
      interval = 1;
      "format-wifi" = "{bandwidthTotalBytes:>3}  ";
      "format-ethernet" = "{ipaddr}/{cidr} ";
      "tooltip-format-wifi" = "{ipaddr} ({signalStrength}%) ";
      "tooltip-format" = "{ifname} via {gwaddr} ";
      "format-linked" = "{ifname} (No IP) ";
      "format-disconnected" = "󰀦";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };

    pulseaudio = {
      format = "{volume}% {icon}";
      "format-bluetooth" = "{volume}% {icon} 󰂯";
      "format-bluetooth-muted" = "󰖁 {icon} 󰂯";
      "format-muted" = "{volume}% 󰖁";
      "format-icons" = {
        headphone = "󰋋";
        "hands-free" = "󱡒";
        headset = "󰋎";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
      };
      "on-click" = "pavucontrol";
    };

    wireplumber = {
      format = "{volume}% {icon}";
      "format-muted" = "{volume}% 󰖁";
      "format-icons" = [ "" "" "" ];
    };

    "custom/power" = {
      format = "{icon}";
      "format-icons" = "";
      "exec-on-event" = "true";
      "on-click" = "~/scripts/session_menu";
      tooltip = false;
    };

    "custom/separator" = {
      format = "{icon}";
      "format-icons" = "|";
      tooltip = false;
    };

    "custom/notification" = {
      tooltip = false;
      format = "{} {icon}";
      "format-icons" = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        "dnd-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-none" = "";
        "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "inhibited-none" = "";
        "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-inhibited-none" = "";
      };
      "return-type" = "json";
      "exec-if" = "which swaync-client";
      exec = "swaync-client -swb";
      "on-click" = "swaync-client -t -sw";
      "on-click-right" = "swaync-client -d -sw";
      escape = true;
    };

    "keyboard-state" = {
      numlock = true;
      capslock = true;
      format = "{name} {icon}";
      "format-icons" = {
        locked = "";
        unlocked = "";
      };
    };

    "wlr/taskbar" = {
      format = "{icon}";
      "icon-size" = 18;
      "tooltip-format" = "{title}";
      "on-click" = "activate";
      "on-click-middle" = "close";
      "ignore-list" = [
        "kitty"
        "wezterm"
        "foot"
        "footclient"
      ];
    };

    "hyprland/window" = {
      format = "{}";
      "separate-outputs" = true;
    };

    battery = {
      bat = "BAT1";
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      "format-charging" = "{capacity}% ";
      "format-plugged" = "{capacity}% ";
      "format-alt" = "{time} {icon}";
      "format-icons" = [ "" "" "" "" "" ];
    };

    "backlight/slider" = {
      min = 0;
      max = 100;
      orientation = "horizontal";
      device = "intel_backlight";
    };

    "idle_inhibitor" = {
      format = "{icon}";
      "format-icons" = {
        activated = "";
        deactivated = "";
      };
    };
  };

  waybarStyle = ''
    @define-color fg #888071;
    @define-color bg #080D0F;
    @define-color bordercolor #080D0F;
    @define-color disabled #A5A5A5;
    @define-color alert #F53C3C;
    @define-color activegreen #26A65B;
    @define-color highlight #F2C187;

    * {
      min-height: 25px;
      font-family: "Roboto", "Font Awesome 6 Free Solid";
      font-size: 15px;
    }

    window#waybar {
      color: @fg;
      background: @bg;
      transition-property: background-color;
      transition-duration: 0.5s;
      border: 2px solid @bordercolor;
      border-radius: 10px;
    }

    window#waybar.empty {
      opacity: 0.3;
    }

    button {
      /* Use box-shadow instead of border so the text isn't offset */
      box-shadow: inset 0 -3px transparent;
      /* Avoid rounded borders under each button name */
      border: none;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    button:hover {
      background: inherit;
      box-shadow: inset 0 -3px transparent;
    }

    #workspaces button {
      color: @fg;
      padding: 0px 10px;
      background: @bg;
    }

    #workspaces button.urgent {
      color: @alert;
    }
    #workspaces button.empty {
      color: @fg;
    }

    #workspaces button.active {
      color: @highlight;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #language,
    #backlight,
    #backlight-slider,
    #network,
    #pulseaudio,
    #wireplumber,
    /* #wireplumber, Duplicated in your CSS, kept one */
    #custom-media,
    #taskbar,
    #tray,
    #tray menu,
    #tray > .needs-attention,
    #tray > .passive,
    #tray > .active,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #custom-power,
    #custom-notification,
    #window,
    #mpd {
      padding: 0px 5px;
      padding-right: 10px;
      margin: 3px 3px;
      color: @fg;
    }

    #custom-separator {
      color: @bordercolor;
    }

    #custom-power {
      color: @fg;
      padding-left: 10px;
    }

    #tray {
      background-color: @bordercolor;
      border-radius: 20px;
      padding: 0px 10px;
      margin: 5px;
    }

    #network.disconnected,
    #pulseaudio.muted,
    #wireplumber.muted {
      color: @alert;
    }

    #battery.charging,
    #battery.plugged {
      color: @activegreen;
    }

    label:focus {
      background-color: @bg;
    }

    #battery.critical:not(.charging) {
      background-color: @alert;
      color: @fg;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    /* If workspaces is the leftmost module, omit left margin */
    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    /* If workspaces is the rightmost module, omit right margin */
    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }

  '';

in
{
  options.rhodium.desktop.bar.waybar = {
    enable = mkEnableOption "Rhodium's Waybar configuration";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [ waybarSettings ];
      style = waybarStyle;
    };
  };
}

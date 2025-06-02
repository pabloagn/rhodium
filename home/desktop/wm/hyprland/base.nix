{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprland-qtutils
  ];

  #  systemd.user.targets.hyprland-session.Unit.Wants = [
  #    "xdg-desktop-autostart.target"
  #  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland = {
      enable = true;
    };
    settings = {
      exec-once = [
        "bash ~/.local/bin/desktop-autostart.sh"
      ];

      input = {
        kb_layout = "gb,us,es";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";
        repeat_delay = 250;
        repeat_rate = 60;
        follow_mouse = 1;
        sensitivity = -0.3;
        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_touch = true;
        workspace_swipe_use_r = true;
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 10;
        gaps_out = 15;
        border_size = 0;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.active_border" = "rgba(00000000)";
        "col.inactive_border" = "rgba(00000000)";
        resize_on_border = false;
        allow_tearing = false;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
        shadow = { };
      };
    };

    extraConfig = ''
      # Monitors
      monitor=eDP-1,2880x1620@120,0x0,1.5

      # Workspaces
      workspace = 1,monitor:eDP-1
      workspace = 2,monitor:eDP-1
      workspace = 3,monitor:eDP-1
      workspace = 4,monitor:eDP-1
      workspace = 5,monitor:eDP-1
      workspace = 6,monitor:eDP-1
      workspace = 7,monitor:eDP-1
      workspace = 8,monitor:eDP-1
      workspace = 9,monitor:eDP-1
      workspace = 10,monitor:eDP-1
    '';
  };
}

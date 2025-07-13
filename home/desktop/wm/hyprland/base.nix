{
  pkgs,
  userPreferences,
  ...
}:
let
  keyboardRepeat = userPreferences.behaviour.keyboardRepeat;
  keyboardDelay = userPreferences.behaviour.keyboardDelay;
in
{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprland-qtutils
  ];

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

      xwayland = {
        force_zero_scaling = true; # Force GUI apps to behave
      };

      input = {
        kb_layout = "gb,us,es";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";
        repeat_delay = keyboardDelay;
        repeat_rate = keyboardRepeat;
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
        "col.active_border" = "rgba(00000000)";
        "col.inactive_border" = "rgba(00000000)";
        resize_on_border = false;
        allow_tearing = false;
      };

      misc = {
        force_default_wallpaper = -1; # Remove default wallpaper
        disable_hyprland_logo = true;
        enable_anr_dialog = false; # Disable non-responsive app dialogues
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
          size = 3;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };
    };
  };
}

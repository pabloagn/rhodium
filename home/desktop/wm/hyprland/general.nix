{ lib, config, ... }:
let
  cursorTheme = "rose-pine-hyprcursor";
  cursorSize = 24;
  animationSpeedFactor = 5;
  keyboardRepeatDelay = 250;
  keyboardRepeatRate = 60;
in
{
  # TODO: Eventually these will be vars
  env = [
    "XCURSOR_SIZE=${cursorSize}"
    "HYPRCURSOR_SIZE=${cursorSize}"
    "HYPRCURSOR_THEME=${cursorTheme}"
  ];

  general = {
    gaps_in = 10;
    gaps_out = 15;
    border_size = 0;
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = 5;
    active_opacity = 1.0;
    inactive_opacity = 0.9;
    # TODO: Check if these are still valid
    # drop_shadow = true
    # shadow_range = 20
    # shadow_render_power = 20
    # col.shadow = rgba(1a1a1aee)

    blur = {
      enabled = true;
      size = 3;
      passes = 3;
      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = true;
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, ${animationSpeedFactor}, myBezier"
      "windowsOut, 1, ${animationSpeedFactor}, default, popin 80%"
      "border, 1, ${animationSpeedFactor}, default"
      "borderangle, 1, ${animationSpeedFactor}, default"
      "fade, 1, ${animationSpeedFactor}, default"
      "workspaces, 1, ${animationSpeedFactor}, default"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  misc = {
    force_default_wallpaper = -1;
    disable_hyprland_logo = true;
  };

  input = {
    # Keyboard
    kb_layout = "gb,us,es";
    kb_variant = "";
    kb_model = "";
    kb_options = "grp:win_space_toggle";
    kb_rules = "";
    repeat_delay = keyboardRepeatDelay;
    repeat_rate = keyboardRepeatRate;

    # Mouse
    follow_mouse = 1;

    # TODO: What the fuck is this for? Keyboard? Mouse? ...
    sensitivity = -0.2;

    touchpad = {
      natural_scroll = false;
    };
  };

  gestures = {
    workspace_swipe = true;
  };

  # TODO: Add mouse, keyboard, touchpad, etc.
  # device = {
  #   name = "epic-mouse-v1";
  #   sensitivity = -0.9;
  # };
}

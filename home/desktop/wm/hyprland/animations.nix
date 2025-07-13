{ ... }:
let
  animationPresets = {
    # Slow
    slow = {
      windows = 8;
      windowsOut = 10;
      border = 15;
      fade = 10;
      workspaces = 8;
    };

    # Balanced
    normal = {
      windows = 5;
      windowsOut = 7;
      border = 10;
      fade = 7;
      workspaces = 6;
    };

    # Fast smooth
    fast = {
      windows = 3;
      windowsOut = 4;
      border = 6;
      fade = 4;
      workspaces = 4;
    };

    # Snappy
    snappy = {
      windows = 2;
      windowsOut = 2;
      border = 3;
      fade = 2;
      workspaces = 2;
    };

    # Instant
    instant = {
      windows = 1;
      windowsOut = 1;
      border = 1;
      fade = 1;
      workspaces = 1;
    };
  };

  currentPreset = animationPresets.fast;
in
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, ${toString currentPreset.windows}, myBezier"
        "windowsOut, 1, ${toString currentPreset.windowsOut}, default, popin 80%"
        "border, 1, ${toString currentPreset.border}, default"
        "fade, 1, ${toString currentPreset.fade}, default"
        "workspaces, 1, ${toString currentPreset.workspaces}, default"
      ];
    };
  };
}

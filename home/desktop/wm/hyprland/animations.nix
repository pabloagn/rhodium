{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
      ];
      animation = [
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 5, default, popin 80%"
        "border, 1, 5, default"
        "borderangle, 1, 5, default"
        "fade, 1, 5, default"
        "workspaces, 1, 5, default"
      ];
    };
  };
}

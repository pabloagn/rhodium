{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];

      # bezier = [
      #   # "myBezier, 0.25, 0.46, 0.45, 0.94" # Less bouncy
      #   # "myBezier, 0.05, 0.9, 0.1, 1.05" # More bouncy
      #   "wind, 0.05, 0.9, 0.1, 1.05"
      #   "winIn, 0.1, 1.1, 0.1, 1.1"
      #   "winOut, 0.3, -0.3, 0, 1"
      #   "liner, 1, 1, 1, 1"
      # ];
      # animation = [
      #   # "windows, 1, 5, myBezier"
      #   "windows, 1, 6, wind, slide"


      #   "windowsOut, 1, 5, default, popin 80%"
      #   # "border, 1, 5, default"
      #   # "borderangle, 1, 5, default"
      #   "fade, 1, 5, default"
      #   "workspaces, 1, 5, default"
      # ];
    };
  };
}

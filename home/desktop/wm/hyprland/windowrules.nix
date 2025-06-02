{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "workspace special:calculator,class:(qalculate-gtk)"
        "workspace special:calendar,class:(foot|st|alacritty|kitty),title:(calcurse)"
        # Add opacity to Zed Editor
        "opacity 0.90, class:(dev.zed.Zed)"
      ];
      layerrule = [
        "noanim, ^(rofi)$"
        "noanim, ^(fuzzel)$"
        "noanim, ^(raffi)$"
      ];
    };
  };
}

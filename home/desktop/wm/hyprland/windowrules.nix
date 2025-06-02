{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "workspace special:calculator,class:(qalculate-gtk)"
        "workspace special:calendar,class:(foot|st|alacritty|kitty),title:(calcurse)"

        # Add transparency
        "opacity 0.95 0.85,class:^(.*)$,focus:0"

        # Zed Editor
        # "opacity 0.95, class:(dev.zed.Zed)"
        # VS Code
        # "opacity 0.95, class:(code)"
        # Firefox
        # "opacity 0.95, class:(firefox)"
        # Zen Browser
        # "opacity 0.95, class:(zen-alpha)"

        # Launchers
        "float,class:^(Rofi)$"
        "center,class:^(Rofi)$"
        "noborder,class:^(Rofi)$"
        "noblur,class:^(Rofi)$"
        "noshadow,class:^(Rofi)$"
        "noanim,class:^(Rofi)$"
        "stayfocused,class:^(Rofi)$"

      ];

      layerrule = [
        "noanim, ^(rofi)$"
        "noanim, ^(fuzzel)$"
        "noanim, ^(raffi)$"
      ];
    };
  };
}

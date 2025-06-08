{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "workspace special:calculator,class:(qalculate-gtk)"
        "workspace special:calendar,class:(foot|st|alacritty|kitty),title:(calcurse)"

        # Transparency
        # "opacity 0.95,class:^(.*)$,focus:0" # All windows

        "opacity 0.95, class:(dev.zed.Zed)" # Zed Editor
        "opacity 0.95, class:(code)" # VS Code
        "opacity 0.95, class:(firefox)" # Firefox
        "opacity 0.95, class:(zen-alpha)" # Zen

        # Launchers - Rofi
        "float,class:^(Rofi)$"
        "center,class:^(Rofi)$"
        "noborder,class:^(Rofi)$"
        "noblur,class:^(Rofi)$"
        "noshadow,class:^(Rofi)$"
        "noanim,class:^(Rofi)$"
        "stayfocused,class:^(Rofi)$"

        # Launchers - Fuzzel
        "float,class:^(raffi)$"
        "center,class:^(raffi)$"
        "noborder,class:^(raffi)$"
        "noshadow,class:^(raffi)$"
        "stayfocused,class:^(raffi)$"
        "animation none,class:^(raffi)$"
        "immediate,class:^(raffi)$"
      ];

      layerrule = [
        "noanim, ^(rofi)$"
        "noanim, ^(fuzzel)$"
        "noanim, ^(raffi)$"
      ];
    };
  };
}

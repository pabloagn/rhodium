{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "workspace special:calculator,class:(qalculate-gtk)"
        "workspace special:calendar,class:(foot|st|alacritty|kitty),title:(calcurse)"

        # Transparency
        "opacity 0.95,class:^(.*)$" # All windows

        # "opacity 0.95, class:(zen-alpha)" # Zen
        # "opacity 0.95, class:(code)" # vs code
        # "opacity 0.95, class:(firefox)" # firefox
        # "opacity 0.95, class:(zen-alpha)" # zen

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

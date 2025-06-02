{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"

        "WLR_REPEAT_RATE,60"
        "WLR_REPEAT_DELAY,250"
      ];
    };
  };
}

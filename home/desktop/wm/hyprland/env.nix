{ userPreferences, ... }:

let
  cursorSize = userPreferences.behaviour.cursorSize;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        # Cursors
        "XCURSOR_SIZE,${toString cursorSize}"
        "HYPRCURSOR_SIZE,${toString cursorSize}"
        "HYPRCURSOR_THEME,phinger-cursors-dark"
        "XCURSOR_THEME,phinger-cursors-dark"

        # X11 scaling
        # "GDK_SCALE,2"
        # "GDK_DPI_SCALE,130"
      ];
    };
  };
}

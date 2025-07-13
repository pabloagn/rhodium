{
  pkgs,
  userPreferences,
  ...
}:
let
  cursorSize = userPreferences.behaviour.cursorSize;
in
{
  home.pointerCursor = {
    enable = true;

    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = cursorSize;

    # Desktops
    gtk.enable = true;
    x11.enable = true;
  };
}

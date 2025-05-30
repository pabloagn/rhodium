{ pkgs, inputs ? {}, lib, ... }:
let
  targetCursor = if inputs ? rose-pine-hyprcursor then {
    name = "rose-pine";
    package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  } else null;
in
{
  home.pointerCursor = lib.mkIf (targetCursor != null) targetCursor;
}

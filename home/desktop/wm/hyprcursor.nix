# home/desktop/wm/hyprcursor.nix

{ lib, config, pkgs, inputs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.wm.hyprcursor;
  cursorTheme = "rose-pine";
  cursorSize = 24;

  rosePineHyprcursorPackage =
    if inputs ? rose-pine-hyprcursor &&
      inputs.rose-pine-hyprcursor ? packages &&
      inputs.rose-pine-hyprcursor.packages ? ${pkgs.system} &&
      inputs.rose-pine-hyprcursor.packages.${pkgs.system} ? default
    then inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    else null;

in
{
  options.rhodium.home.desktop.wm.hyprcursor = {
    enable = mkEnableOption "Rhodium's Hyprcursor configuration";
    theme = mkOption { type = types.str; default = "rose-pine"; };
    size = mkOption { type = types.int; default = 24; };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprcursor
    ] ++ (lib.optional (rosePineHyprcursorPackage != null) rosePineHyprcursorPackage);

    home.pointerCursor = mkIf (rosePineHyprcursorPackage != null) {
      name = cursorTheme;
      package = rosePineHyprcursorPackage;
      size = cursorSize;
      gtk.enable = true;
      x11.enable = true;
      # For Wayland native apps, environment variables might be needed depending on compositor
      # e.g., XCURSOR_THEME, XCURSOR_SIZE
      # Hyprland itself might pick it up from its config or xsettingsd/gsettings.
    };
  };
}

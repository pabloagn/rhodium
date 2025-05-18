# home/desktop/wm/hyprcursor.nix

{ lib, config, pkgs, inputs ? { }, ... }:

with lib;
let
  cfg = config.rhodium.desktop.wm.hyprcursor;
  cursorTheme = "rose-pine";
  cursorSize = 24;
in
{
  options.rhodium.desktop.wm.hyprcursor = {
    enable = mkEnableOption "Rhodium's Hyprcursor configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprcursor
      (if inputs ? rose-pine-hyprcursor then inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default else null)
    ];

    home.pointerCursor = {
      name = cursorTheme;
      package =
        if inputs ? rose-pine-hyprcursor
        then inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        else null;
      size = cursorSize;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}

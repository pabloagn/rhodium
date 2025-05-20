# home/development/editors/cursor.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.cursor;
in
{
  options.rhodium.home.development.editors.cursor = {
    enable = mkEnableOption "Cursor Editor";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      code-cursor
    ];
  };
}

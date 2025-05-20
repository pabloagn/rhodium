# home/development/editors/mousepad.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.mousepad;
in
{
  options.rhodium.home.development.editors.mousepad = {
    enable = mkEnableOption "Rhodium's Mousepad configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mousepad
    ];
  };
}

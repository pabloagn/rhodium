# modules/desktop/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop;
in
{
  imports = [
    ./wm
    ./apps
  ];

  options.rhodium.system.desktop = {
    enable = mkEnableOption "Rhodium's desktop configuration";
  };

  config = mkIf cfg.enable {
  };
}

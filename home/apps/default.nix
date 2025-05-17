# home/apps/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps;
in {
  imports = [
    ./desktop
    ./communication
    ./browsers
    ./documents
    ./media
    ./utilities
    ./terminals
  ];

  options.rhodium.apps = {
    enable = mkEnableOption "Rhodium's applications";
  };

  config = mkIf cfg.enable {
  };
}

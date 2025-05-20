# modules/development/virtualization/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.virtualization;
in

{
  imports = [
    ./docker.nix
  ];

  options.rhodium.system.development.virtualization = {
    enable = mkEnableOption "Enable virtualization";
  };

  config = mkIf cfg.enable {
  };
}

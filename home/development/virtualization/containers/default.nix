# home/development/virtualization/containers.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.containers;
in
{
  options.rhodium.development.virtualization.containers = {
    enable = mkEnableOption "Rhodium's container tools";
  };

  config = mkIf cfg.enable {
  };
}

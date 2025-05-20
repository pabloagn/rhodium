# home/development/virtualization/containers.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.virtualization.containers;
in
{
  imports = [
    ./docker.nix
    ./kubernetes.nix
    ./podman.nix
  ];

  options.rhodium.home.development.virtualization.containers = {
    enable = mkEnableOption "Rhodium's container tools";
  };

  config = mkIf cfg.enable {
    rhodium.home.development.virtualization.containers = {
      docker.enable = true;
      kubernetes.enable = false;
      podman.enable = false;
    };
  };
}

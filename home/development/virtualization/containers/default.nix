# home/development/virtualization/containers.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.containers;
in
{
  imports = [
    ./docker.nix
    ./kubernetes.nix
    ./podman.nix
  ];

  options.rhodium.development.virtualization.containers = {
    enable = mkEnableOption "Rhodium's container tools";
  };

  config = mkIf cfg.enable {
    home.development.virtualization.containers.docker.enable = true;
    home.development.virtualization.containers.kubernetes.enable = true;
    home.development.virtualization.containers.podman.enable = true;
  };
}

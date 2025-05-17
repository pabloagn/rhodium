# home/development/virtualization/containers/podman.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.development.virtualization.containers.podman;
in
{
  options.rhodium.development.virtualization.containers.podman = {
    enable = mkEnableOption "Enable Podman containerization";
  };

  config = mkIf (config.rhodium.development.virtualization.containers.enable && cfg.enable) {
    home.packages = with pkgs; [
      podman
      podman-tui
    ];
  };
}

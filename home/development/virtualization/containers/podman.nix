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

  config = mkIf cfg.enable {
    services.podman = {
      enable = true;
    };

    home.packages = with pkgs; [
      podman-tui
    ];
  };
}

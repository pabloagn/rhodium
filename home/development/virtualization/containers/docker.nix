# home/development/virtualization/containers/docker.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.containers.docker;
in
{
  options.rhodium.development.virtualization.containers.docker = {
    enable = mkEnableOption "Rhodium's Docker configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      docker
    ];
  };
}

# modules/development/virtualization/docker.nix

{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Add my user to the docker group
  users.users.pabloagn.extraGroups = [ "docker" ];
}

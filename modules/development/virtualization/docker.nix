# modules/development/virtualization/docker.nix

{ config, pkgs, lib, userData, hostData, ... }:

with lib;

let
  cfg = config.rhodium.system.development.virtualization.docker;
  usersForDockerGroup = attrNames (filterAttrs
    (userName: userDef:
      (config.users.users ? ${userName}) && (userData.${userName}.addToDockerGroup or false)
    )
    userData);
in
{
  options.rhodium.system.development.virtualization.docker = {
    enable = mkEnableOption "Rhodium Docker virtualization configuration";
    enableOnBoot = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable the Docker daemon to start on boot.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      inherit (cfg) enableOnBoot;
    };

    users.users = listToAttrs (map
      (username:
        nameValuePair username {
          extraGroups = [ "docker" ];
        }
      )
      usersForDockerGroup);
  };
}

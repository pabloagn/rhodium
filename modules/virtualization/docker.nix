# modules/virtualization/docker.nix

{ lib, config, pkgs, _haumea, rhodiumLib, userData, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  usersForDockerGroup = attrNames (filterAttrs
    (userName: userDef:
      (config.users.users ? ${userName}) && (userData.${userName}.addToDockerGroup or false)
    )
    userData);
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        hasDesktop = false;
        defaultEnable = false;
      }
    //
    {
      enableOnBoot = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable the Docker daemon to start on boot.";
      };
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
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

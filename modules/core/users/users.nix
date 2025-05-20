# modules/core/users/users.nix

{ lib, config, pkgs, userData, ... }:

let
  hostDeclaredGroups = config.rhodium.host.groups;

  activeUsers = lib.filterAttrs
    (userKey: userDef:
      lib.any (userHostGroup: lib.elem userHostGroup hostDeclaredGroups) (userDef.hostGroups or [ ])
    )
    userData;

  nixosUserConfigurations = lib.mapAttrs'
    (userKey: userDef: {
      name = userDef.username;
      value = {
        isNormalUser = userDef.isNormalUser;
        description = userDef.fullName;
        extraGroups = userDef.extraGroups or [ ];
        home = "/home/${userDef.username}";
        createHome = true;
        shell =
          if builtins.hasAttr userDef.shell pkgs
          then builtins.getAttr userDef.shell pkgs
          else pkgs.bash;
      };
    })
    activeUsers;
in
{
  users.users = nixosUserConfigurations;
  users.groups = lib.genAttrs (map (ud: ud.username) (lib.attrValues activeUsers)) (_: { });
}

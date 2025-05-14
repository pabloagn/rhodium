# modules/core/user-implementation.nix

{ config, lib, pkgs, hostname, ... }:

let
  cfg = config.mySystem;

  # Import the user manifest - single source of truth
  userManifest = import ../../users/manifest.nix;

  # Filter users for this host from the manifest
  usersForThisHost = lib.filter
    (user: lib.elem hostname user.hosts)
    userManifest.users;

  # Convert shell string to package
  getShellPackage = shellName:
    if shellName == "bash" then pkgs.bash
    else if shellName == "zsh" then pkgs.zsh
    else if shellName == "fish" then pkgs.fish
    else if shellName == "nushell" then pkgs.nushell
    else pkgs.bash; # Default fallback

  # Get groups for a user based on their roles
  getUserGroups = roles:
    [ "users" ] ++ # Base group
    lib.flatten (map
      (role:
        if lib.hasAttr role cfg.userRoles.definitions
        then cfg.userRoles.definitions.${role}.groups
        else []
      )
      roles
    );

  # Get packages for a user based on their roles
  getUserPackages = roles:
    lib.flatten (map
      (role:
        if lib.hasAttr role cfg.userRoles.definitions
        then cfg.userRoles.definitions.${role}.packages
        else []
      )
      roles
    );

  # Get home modules for a user based on their roles
  getUserHomeModules = roles:
    lib.flatten (map
      (role:
        if lib.hasAttr role cfg.userRoles.definitions
        then cfg.userRoles.definitions.${role}.homeModules
        else []
      )
      roles
    );

  # Create user configuration for a specific user
  mkUserConfig = user: {
    isNormalUser = true;
    description = user.description;
    shell = getShellPackage user.shell;
    extraGroups = getUserGroups user.roles;
    packages = getUserPackages user.roles;
  };

  # Create all users for this host
  userConfigs = builtins.listToAttrs (
    map
      (user: {
        name = user.name;
        value = mkUserConfig user;
      })
      usersForThisHost
  );
in
{
  # Import role definitions
  imports = [ ./user-roles.nix ];

  # Apply user configurations
  users.users = userConfigs;

  # Home Manager configuration
  home-manager.users = builtins.listToAttrs (
    map
      (user: {
        name = user.name;
        value = { ... }: {
          imports = [ ../../home/default.nix ];
          myHome = {
            roles = user.roles;
            profile =
              if lib.elem "developer" user.roles then "developer"
              else if lib.elem "desktop" user.roles then "desktop"
              else "minimal";
          };
        };
      })
      usersForThisHost
  );
}

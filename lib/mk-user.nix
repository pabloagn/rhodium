# library/mk-user.nix

{ lib, pkgs, inputs ? null, self ? null, ... }:

rec {
  # User role templates for different user types
  userRoleTemplates = {
    admin = { name, description, shell ? pkgs.bash, extraConfig ? { } }:
      {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "sudo" ];
        inherit description shell;
      } // extraConfig;

    developer = { name, description, shell ? pkgs.bash, extraConfig ? { } }:
      {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "docker" "vboxusers" "dialout" ];
        inherit description shell;
      } // extraConfig;

    desktop = { name, description, shell ? pkgs.bash, extraConfig ? { } }:
      {
        isNormalUser = true;
        extraGroups = [ "networkmanager" ];
        inherit description shell;
      } // extraConfig;
  };

  # Function to create home-manager configuration based on user role
  mkHomeConfig = { username, roles, hostname ? null, extraModules ? [ ] }:
    let
      baseModules = builtins.concatMap
        (role:
          if builtins.hasAttr role self.rhodium.home.profiles
          then [ self.rhodium.home.profiles.${role} ]
          else [ ]
        )
        roles;
    in
    {
      imports = baseModules ++ extraModules;
    };

  # Function to create users from user manifest
  mkUsersFromManifest = manifestPath:
    let
      manifest = import manifestPath;

      # Process each user entry in the manifest
      processUser = user: host:
        if builtins.elem host.name user.hosts then
          {
            name = user.name;
            value =
              let
                # Combine role configurations
                roleConfigs = builtins.map
                  (role:
                    if builtins.hasAttr role userRoleTemplates
                    then userRoleTemplates.${role} { inherit (user) name description shell; }
                    else { }
                  )
                  user.roles;

                # Merge all role configurations
                mergedConfig = lib.foldl lib.recursiveUpdate { } roleConfigs;
              in
              mergedConfig;
          }
        else null;

      # Get all users for a given host
      getUsersForHost = host:
        builtins.filter (x: x != null) (
          builtins.map (user: processUser user host) manifest.users
        );

      # Create a map of host -> users
      hostUsers = builtins.listToAttrs (
        builtins.map
          (host: {
            name = host.name;
            value = builtins.listToAttrs (getUsersForHost host);
          })
          manifest.hosts
      );
    in
    hostUsers;
}

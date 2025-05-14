# library/mk-host.nix

{ lib, pkgs, inputs, self, ... }:

rec {
  # Host type templates for different system types
  hostTemplates = {
    wsl = { name, system ? "x86_64-linux", extraModules ? [], hostSpecificAttrs, currentSystemPkgs, flakeO }:
      flakeO.inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inputs = flakeO.inputs;
          hostname = name;
          rhodium = flakeO.rhodium;
          pkgs = currentSystemPkgs;
          currentHost = hostSpecificAttrs;
        };

        modules = [
          { nixpkgs.overlays = [ flakeO.rhodium.overlays.default ]; }
          flakeO.rhodium.system.default
          ../../hosts/common/wsl.nix
          flakeO.inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inputs = flakeO.inputs;
              rhodium = flakeO.rhodium;
              inherit lib;
              pkgs = currentSystemPkgs;
              hostname = name;
            };
            home-manager.users = lib.mapAttrs (userName: userConfigFromManifest:
              let
                userFile = ../../Users/${userName}.nix;
                userImports =
                  if builtins.pathExists userFile then
                    [(import userFile ({
                      inputs = flakeO.inputs;
                      pkgs = currentSystemPkgs;
                      inherit lib;
                      rhodium = flakeO.rhodium;
                      currentUser = userName;
                      userConfig = userConfigFromManifest;
                    }))]
                  else
                    (lib.traceWarnIf (userConfigFromManifest ? fileExpected && userConfigFromManifest.fileExpected)
                      "User file for ${userName} not found at ${toString userFile}, but was expected."
                      []);
              in
              {
                imports = userImports ++ (userConfigFromManifest.homeModules or []);
              }
            ) (hostSpecificAttrs.users or {});
          }
        ] ++ extraModules ++ (hostSpecificAttrs.nixosModules or []);
      };

    desktop = { name, system ? "x86_64-linux", extraModules ? [], hostSpecificAttrs, currentSystemPkgs, flakeO }:
      flakeO.inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inputs = flakeO.inputs;
          hostname = name;
          rhodium = flakeO.rhodium;
          pkgs = currentSystemPkgs;
          currentHost = hostSpecificAttrs;
        };

        modules = [
          { nixpkgs.overlays = [ flakeO.rhodium.overlays.default ]; }
          flakeO.rhodium.system.default
          flakeO.rhodium.system.desktop
          ../../hosts/common/desktop.nix
          flakeO.inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inputs = flakeO.inputs;
              rhodium = flakeO.rhodium;
              inherit lib;
              pkgs = currentSystemPkgs;
              hostname = name;
              currentHost = hostSpecificAttrs;
            };
            home-manager.users = lib.mapAttrs (userName: userConfigFromManifest:
              let
                userFile = ../../Users/${userName}.nix;
                userImports =
                  if builtins.pathExists userFile then
                    [(import userFile ({
                      inputs = flakeO.inputs;
                      pkgs = currentSystemPkgs;
                      inherit lib;
                      rhodium = flakeO.rhodium;
                      currentUser = userName;
                      userConfig = userConfigFromManifest;
                    }))]
                  else
                    (lib.traceWarnIf (userConfigFromManifest ? fileExpected && userConfigFromManifest.fileExpected)
                      "User file for ${userName} not found at ${toString userFile}, but was expected."
                      []);
              in
              {
                imports = userImports ++ (userConfigFromManifest.homeModules or []);
              }
            ) (hostSpecificAttrs.users or {});
          }
        ] ++ extraModules ++ (hostSpecificAttrs.nixosModules or []);
      };
  };

  # Function to create hosts from a manifest file
  mkHostsFromManifest = { manifestPath, flakeOutputs }:
    let
      manifestData = import manifestPath;
      hostList = lib.mapAttrsToList (hostName: hostAttrs: hostAttrs // {
        name = hostName;
      }) manifestData;

    in
    builtins.listToAttrs (map
      (hostConfig: {
        name = hostConfig.name;
        value = hostTemplates.${hostConfig.type} {
          inherit (hostConfig) name;
          system = hostConfig.system or "x86_64-linux";
          extraModules = hostConfig.extraModules or [];
          hostSpecificAttrs = hostConfig;
          currentSystemPkgs = flakeOutputs.nixpkgs.legacyPackages.${hostConfig.system or "x86_64-linux"};
          flakeO = flakeOutputs;
        };
      })
      hostList);
}

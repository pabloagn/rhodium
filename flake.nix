# flake.nix
{
  description = "Rhodium | A Hypermodular NixOS System";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR for Firefox extensions
    nur = {
      url = "github:nix-community/NUR";
    };
    # Unofficial Zen Browser Input (Requires unstable)
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };
    # Hyprcursor requirements
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };
  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , zen-browser
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nur.overlay
        ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nur.overlay
        ];
      };

      rhodiumLib = import ./lib { inherit lib pkgs; };
      dataPath = ./data;
      dataPathUsers = dataPath + "/users/";
      dataPathHosts = dataPath + "/hosts/";
      userData =
        if builtins.pathExists dataPathUsers + "/users.nix"
        then (import (dataPathUsers + "/users.nix")).users
        else { };
      hostData =
        if builtins.pathExists dataPathHosts + "/hosts.nix"
        then (import (dataPathHosts + "/hosts.nix")).hosts
        else { };

      themeConfig = import ./home/assets/themes/chiaroscuro.nix { inherit pkgs; };
    in
    {
      nixosConfigurations = {
        host_001 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/host_001
          ];
          specialArgs = {
            inherit pkgs pkgs-unstable inputs rhodiumLib;
            users = userData;
            host = hostData.host_001 or { };
          };
        };
        host_002 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/host_002
          ];
          specialArgs = {
            inherit pkgs pkgs-unstable inputs rhodiumLib;
            users = userData;
            host = hostData.host_002 or { };
          };
        };
      };
      homeConfigurations = {
        user_001 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/user_001
          ];
          extraSpecialArgs = {
            inherit pkgs-unstable inputs rhodiumLib;
            user = userData.user_001 or { };
            theme = themeConfig.theme.dark;
          };
        };
      };
    };
}

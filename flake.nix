# flake.nix

{
  description = "Rhodium | Hyper-Modular Declarative NixOS System";

  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    , flake-parts
    , home-manager
    , zen-browser
    , ...
    }:
    let
      data = import ./.env.nix {
        pkgs = nixpkgs;
      };

      allUsersData = data.users;
      allHostsData = data.hosts;

      system = "x86_64-linux";

      rhodiumGlobalOverlays = import ./overlays {
        inherit inputs;
      };

      commonPkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays = [ rhodiumGlobalOverlays ];
      };

      configuredPkgs = import inputs.nixpkgs ({
        inherit system;
      } // commonPkgsConfig);

      configuredPkgsUnstable = import inputs.nixpkgs-unstable ({
        inherit system;
      } // commonPkgsConfig);

      rhodiumSystemModules = {
        defaults = import ./modules;

        core = {
          defaults = import ./modules/core;
          boot = import ./modules/core/boot;
          filesystem = import ./modules/core/filesystem;
          groups = import ./modules/core/groups;
          hardware = import ./modules/core/hardware;
          networking = import ./modules/core/networking;
          security = import ./modules/core/security;
          shell = import ./modules/core/shell;
          system = import ./modules/core/system;
          users = import ./modules/core/users;
          utils = import ./modules/core/utils;
        };

        desktop = {
          defaults = import ./modules/desktop;
        };

        development = {
          defaults = import ./modules/development;
        };
      };

      rhodiumHomeModules = {
        defaults = import ./home;
        apps = import ./home/apps;
        desktop = import ./home/desktop;
        development = import ./home/development;
        environment = import ./home/environment;
        security = import ./home/security;
        shell = import ./home/shell;
        system = import ./home/system;
      };

      rhodiumLib = import ./lib {
        lib = configuredPkgs.lib;
        inherit inputs;
        flakeRootPath = self;
      };

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];

      perSystem = { config, system, lib, self', inputs', ... }:
        {
          packages = {
            rustWorkspaceSrc = ./tools;

            color-provider = configuredPkgs.rustPlatform.buildRustPackage {
              pname = "color-provider";
              version = "0.1.0";
              src = ./tools;
              rootCargoToml = "./color-provider/Cargo.toml";
              cargoLock.lockFile = ./tools/Cargo.lock;
              description = "Color Provider";
            };

            nixos-cli = configuredPkgs.rustPlatform.buildRustPackage {
              pname = "nixos-cli";
              version = "0.1.0";
              src = ./tools;
              rootCargoToml = "./nixos-cli/Cargo.toml";
              cargoLock.lockFile = ./tools/Cargo.lock;
              description = "Nixos CLI";
            };

            default = self'.packages.color-provider;
          };

          devShells.default = configuredPkgs.mkShell {
            name = "rhodium-dev";
            nativeBuildInputs = with configuredPkgs; [
              rustc
              cargo
              rust-analyzer
              nil
              nixpkgs-fmt
              direnv
              nix-direnv
              yazi
            ];
            RUST_SRC_PATH = "${configuredPkgs.rustPlatform.rustLibSrc}";

            shellHook = ''
              echo "Entered Rust workspace development shell."
              # Consider if 'cd tools' is always desired or should be in a specific dev shell
              # cd tools
              # echo "Current directory: $(pwd)"
            '';
          };
        };

      flake = {
        rhodium = {
          system = rhodiumSystemModules;
          home = rhodiumHomeModules;
          overlays = rhodiumGlobalOverlays;
          lib = rhodiumLib;
        };

        nixosConfigurations = nixpkgs.lib.mapAttrs'
          (hostKey: hostSpecificData: {
            name = hostSpecificData.hostname;
            value = nixpkgs.lib.nixosSystem {
              inherit system;
              pkgs = configuredPkgs;
              specialArgs = {
                inherit inputs;
                pkgs-unstable = configuredPkgsUnstable;
                userData = allUsersData;
                hostData = hostSpecificData;
                flakeRootPath = self;
                rhodium = self.rhodium;
              };
              modules = [
                ./hosts/${hostKey}/default.nix
              ];
            };
          })
          allHostsData;

        homeConfigurations = nixpkgs.lib.mapAttrs'
          (userKey: userSpecificData: {
            name = userSpecificData.username;
            value = home-manager.lib.homeManagerConfiguration {
              pkgs = configuredPkgs;
              extraSpecialArgs = {
                inherit inputs;
                pkgs-unstable = configuredPkgsUnstable;
                userData = userSpecificData;
                flakeRootPath = self;
                rhodium = self.rhodium;
              };
              modules = [
                ./users/${userKey}/default.nix
              ];
            };
          })
          allUsersData;
      };
    };
}

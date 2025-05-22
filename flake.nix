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

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    , flake-parts
    , home-manager
    , zen-browser
    , haumea
    , ...
    }:
    let
      system = "x86_64-linux";
      rhodiumGlobalOverlays = import ./overlays { inherit inputs; };

      # Rhodium's Packages (base)
      commonPkgsConfig = {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ rhodiumGlobalOverlays ];
      };

      # Rhodium's Packages (stable, inherits commonPkgsConfig)
      configuredPkgs = import inputs.nixpkgs commonPkgsConfig;

      # Rhodium's Packages (unstable, inherits commonPkgsConfig)
      configuredPkgsUnstable = import inputs.nixpkgs-unstable commonPkgsConfig;

      # Rhodium's Data
      dataHosts = import ./data/hosts/hosts.nix { pkgs = configuredPkgs; };
      dataUsers = import ./data/users/users.nix { pkgs = configuredPkgs; };

      # Haumea Transformer
      rhodiumHaumeaTransformer = pkgsForLib: pathPrefix:
        cursor: moduleData:
          let lib = pkgsForLib.lib;
          in moduleData // {
            _haumea = {
              path = cursor;
              name = if cursor == [ ] then "root" else lib.last cursor;
              configPath = pathPrefix ++ cursor;
              configPathPrefix = pathPrefix;
            };
          };

      # Rhodium's Lib
      rhodiumLib = import ./lib {
        inherit inputs;
        pkgs = configuredPkgs;
        pkgs-unstable = configuredPkgsUnstable;
        flakeRootPath = self;
        lib = configuredPkgs.lib;
      };

      # Haumea Modules
      baseHaumeaInputs = {
        inherit inputs rhodiumLib;
        flakePath = self;
      };

      # Rhodium's NixOS Modules (Haumea-injected)
      rhodiumSystemModules = haumea.lib.load {
        src = ./modules;
        inputs = baseHaumeaInputs // {
          pkgs = configuredPkgs;
          pkgs-unstable = configuredPkgsUnstable;
          lib = configuredPkgs.lib;
        };
        transformer = rhodiumHaumeaTransformer configuredPkgs [ "rhodium" "system" ];
      };

      # Rhodium's Home Manager Modules (Haumea-injected)
      rhodiumHomeModules = haumea.lib.load {
        src = ./home;
        inputs = baseHaumeaInputs // {
          pkgs = configuredPkgs;
          pkgs-unstable = configuredPkgsUnstable;
          lib = configuredPkgs.lib;
        };
        transformer = rhodiumHaumeaTransformer configuredPkgs [ "rhodium" "home" ];
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

        nixosConfigurations = configuredPkgs.lib.mapAttrs'
          (hostKey: hostSpecificData: {
            name = hostSpecificData.hostname;
            value = configuredPkgs.lib.nixosSystem {
              inherit system;
              pkgs = configuredPkgs;
              specialArgs = {
                inherit inputs;
                pkgs-unstable = configuredPkgsUnstable;
                userData = dataUsers;
                hostData = hostSpecificData;
                flakeRootPath = self;
                rhodium = self.rhodium;
              };
              modules = [
                ./hosts/${hostKey}/default.nix
              ] ++ configuredPkgs.lib.attrValuesRecursive self.rhodium.system;
            };
          })
          dataHosts;

        homeConfigurations = configuredPkgs.lib.mapAttrs'
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
              ] ++ configuredPkgs.lib.attrValuesRecursive self.rhodium.home;
            };
          })
          dataUsers;
      };
    };
}

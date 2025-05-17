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
      system = "x86_64-linux";
      rhodiumGlobalOverlay = import ./overlays { inherit inputs; };

      configuredPkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ rhodiumGlobalOverlay ];
      };

      configuredPkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ rhodiumGlobalOverlay ];
      };

      # System Modules
      rhodiumSystemModules = {
        core = import ./modules/core;
        desktop = import ./modules/desktop;
        development = import ./modules/development;
        system = import ./modules/system;
        themes = import ./modules/themes;

        # Complete system configuration for easy import
        default = { rhodium, ... }: {
          imports = [
            rhodium.system.core
            rhodium.system.themes
          ];
        };
      };

      # Home Modules
      rhodiumHomeModules = {
        defaults = import ./home/default.nix;
        # options = import ./home/options.nix;

        # Shell Environment
        shell = import ./home/shell/default.nix;

        # Desktop Environment
        desktop = import ./home/desktop/default.nix;

        # Development Environment
        development = import ./home/development/default.nix;
      };

      rhodiumLib = import ./lib {
        inherit inputs;
      };

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];

      perSystem = { config, pkgs, system, lib, self', inputs', ... }:

        let
          perSystemConfiguredPkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ rhodiumGlobalOverlay ];
          };
        in
        {
          packages = {
            # Rust Workspace Source
            rustWorkspaceSrc = ./tools;

            # Color Provider Package
            color-provider = perSystemConfiguredPkgs.rustPlatform.buildRustPackage {
              pname = "color-provider";
              version = "0.1.0";
              src = ./tools;
              rootCargoToml = "./color-provider/Cargo.toml";
              cargoLock.lockFile = ./tools/Cargo.lock;
            };

            # Nixos CLI Package
            nixos-cli = perSystemConfiguredPkgs.rustPlatform.buildRustPackage {
              pname = "nixos-cli";
              version = "0.1.0";
              src = ./tools;
              rootCargoToml = "./nixos-cli/Cargo.toml";
              cargoLock.lockFile = ./tools/Cargo.lock;
            };

            # Default package
            default = self'.packages.color-provider;
          };

          # Dev Shell for Workspace
          devShells.default = perSystemConfiguredPkgs.mkShell {
            name = "rhodium-dev";
            nativeBuildInputs = with perSystemConfiguredPkgs; [
              rustc
              cargo
              rust-analyzer
              nil
              nixpkgs-fmt
              direnv
              nix-direnv
              yazi
            ];
            RUST_SRC_PATH = "${perSystemConfiguredPkgs.rustPlatform.rustLibSrc}";

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
          overlays.default = rhodiumGlobalOverlay;
          lib = rhodiumLib;
        };

        nixosConfigurations = {
          "rhodium-native" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              flakeOutputs = self;
              hostName = "rhodium-native";
              pkgs-unstable = configuredPkgsUnstable;
            };

            modules = [
              ./hosts/native

              ({ pkgs, ... }: {
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ self.rhodium.overlays.default ];
              })
            ];
          };

          "rhodium-wsl2" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              flakeOutputs = self;
              hostName = "rhodium-wsl2";
              pkgs-unstable = configuredPkgsUnstable;
            };
            modules = [
              ./hosts/wsl2

              ({ pkgs, ... }: {
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ self.rhodium.overlays.default ];
              })
            ];
          };
        };

        homeConfigurations."pabloagn" = home-manager.lib.homeManagerConfiguration {
          pkgs = configuredPkgs;
          extraSpecialArgs = {
            inherit inputs;
            flakeOutputs = self;
            pkgs-unstable = configuredPkgsUnstable;
          };
          modules = [
            ./users/pabloagn
          ];
        };
      };
    };
}

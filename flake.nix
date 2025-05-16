# flake.nix

{
  description = "Rhodium | Hyper-Modular Declarative NixOS System";

  inputs = {

    nixpkgs = {
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

  };

  outputs = inputs@{ self, nixpkgs, flake-parts, home-manager, zen-browser, ... }:
    let
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
        options = import ./home/options.nix;
        linker = import ./home/modules/linker.nix;

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
      systems = [ "x86_64-linux" ];

      perSystem = { config, pkgs, system, lib, self', inputs', ... }: {

        packages = {
          # Rust Workspace Source
          rustWorkspaceSrc = ./tools;

          # Color Provider Package
          color-provider = pkgs.rustPlatform.buildRustPackage {
            pname = "color-provider";
            version = "0.1.0";
            src = ./tools;
            rootCargoToml = "./color-provider/Cargo.toml";
            cargoLock.lockFile = ./tools/Cargo.lock;
          };

          # Nixos CLI Package
          nixos-cli = pkgs.rustPlatform.buildRustPackage {
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
        devShells.default = pkgs.mkShell {
          name = "rhodium-dev";
          nativeBuildInputs = with pkgs; [
            rustc
            cargo
            rust-analyzer
            nil
            nixpkgs-fmt
            direnv
            nix-direnv
            yazi
          ];
          RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

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
          overlays.default = import ./overlays { inherit inputs; };
          lib = rhodiumLib;
        };

        nixosConfigurations = {
          "rhodium-native" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              flakeOutputs = self;
              hostName = "rhodium-native";
            };
            modules = [
              ./hosts/native
            ];
          };

          "rhodium-wsl2" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              flakeOutputs = self;
              hostName = "rhodium-wsl2";
            };
            modules = [ ./hosts/wsl2 ];
          };
        };
        homeConfigurations."pabloagn" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs;
            flakeOutputs = self;
            self = self;
          };
          modules = [
            ./users/pabloagn
          ];
        };
      };
    };
}

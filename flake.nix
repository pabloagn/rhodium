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
      url = "https://flakehub.com/f/youwen5/zen-browser/0.1.169";
    };

  };

  outputs = inputs@{ self, nixpkgs, flake-parts, home-manager, zen-browser, ... }:
    let
      # Define system-agnostic module paths/structures
      # These are not evaluated with specific pkgs yet.
      rhodiumSystemModules = {
        core = import ../modules/core;
        desktop = import ../modules/desktop;
        development = import ../modules/development;
        security = import ../modules/security;
        services = import ../modules/services;
        system = import ../modules/system;
        themes = import ../modules/themes;
        profiles = import ../modules/profiles; # Assuming this contains system profiles

        # Complete system configuration for easy import
        default = { rhodium, ... }: {
          imports = [
            rhodium.system.core
            rhodium.system.themes
            # Add other essential base modules here if needed
          ];
        };
      };

      rhodiumHomeModules = {
        options = import ../home/options.nix; # Path to Home Manager option definitions
        profiles = {
          developer = import ../home/profiles/developer.nix;
          desktop = import ../home/profiles/desktop.nix;
          admin = import ../home/profiles/admin.nix;
        };
        roles = { # Assuming these are Home Manager roles/module sets
          developer = import ../home/roles/developer.nix;
          desktop = import ../home/roles/desktop.nix;
          admin = import ../home/roles/admin.nix;
        };
        default = import ../home/default.nix; # Default Home Manager profile/imports
      };

      # This is the primary instance of your library, used for generating configurations.
      # It's defined once and its functions should handle system-specifics internally.
      rhodiumLib = import ../lib {
        inherit inputs;
        # 'self' will be passed to functions like mkHostsFromManifest later,
        # once the full flake output 'self' is available.
        # pkgsFor = system: nixpkgs.legacyPackages.${system}; # Example if lib needs this directly
        # lib = nixpkgs.lib; # Pass nixpkgs.lib if your lib expects it explicitly
      };

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { config, pkgs, system, lib, self', inputs', ... }: { # lib here is nixpkgs.lib

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

        # This is a per-system instance of your library, if needed for per-system tasks.
        # It's instantiated with system-specific `pkgs`.
        rhodiumLibPerSystem = import ../lib {
          inherit inputs pkgs;
          # self = inputs.self; # If it needs access to final flake outputs
        };
      };

      flake = {
        # Expose your organized modules and overlays
        rhodium = {
          system = rhodiumSystemModules;
          home = rhodiumHomeModules;
          overlays.default = import ../overlays { inherit inputs; };
          # Expose the main library instance
          lib = rhodiumLib;
        };

        # Generate NixOS configurations from manifest
        # 'self' here refers to the final flake outputs
        nixosConfigurations =
          # mkHostsFromManifest should be a function in your rhodiumLib
          self.rhodium.lib.mkHostsFromManifest {
            manifestPath = ../hosts/manifest.nix;
            # Pass the fully evaluated flake outputs so your library can access
            # self.rhodium.system modules, self.rhodium.home modules, etc.
            flakeOutputs = self;
          };

        # You could also define homeConfigurations here if you manage them separately
        # from nixosConfigurations, using a similar pattern:
        # homeConfigurations = self.rhodium.lib.mkHomeConfigurations {
        #   manifestPath = ../users/manifest.nix; # Or similar
        #   flakeOutputs = self;
        # };
      };
    };
}

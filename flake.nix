# flake.nix

{
  description = "Hyper-Modular NixOS Design System Factory";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, nixpkgs, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {

        packages = {

          # Rust Workspace Source (Cargo.toml lives here)
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
          name = "nixos-design-system-dev";
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
            cd tools
            echo "Current directory: $(pwd)"
          '';
        };
      };

      flake = {
        nixosConfigurations.dummyHost = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ({ pkgs, ... }: { networking.hostName = "dummy"; system.stateVersion = "23.11"; }) ];
        };
      };
    };
}

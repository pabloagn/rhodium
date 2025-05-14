# flake.nix

{
  description = "Hyper-Modular NixOS Design System Factory";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, home-manager, ... }:

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
        nixosConfigurations = {
          "nixos-wsl2" = nixpkgs.lib.nixosSystem {

            system = "x86_64-linux";

            specialArgs = {
              inherit inputs;
              hostname = "nixos-wsl2";
            };

            modules = [
              # Base host config (chassis type)
              ./hosts/nixos-wsl2 # Sets system.stateVersion, boot.isContainer, etc.

              # Import modules that define options and implement them
              ./modules/core/default.nix # This will import system-profiles/options.nix and shells/default.nix
              # ./modules/desktop/default.nix # We'd conditionally import this based on a hostProfile option
              ./modules/themes/default.nix # For theme options

              # User definitions (who is driving)
              ./users/pabloagn.nix

              # Home Manager (driver's personal seat settings & gadgets)
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.users.pabloagn = {
                  imports = [ ./home/profiles/developer.nix ];
                  # Customer pabloagn might override their own shell here,
                  # which takes precedence over users.defaultUserShell for pabloagn
                  programs.zsh.enable = true; # Example if zsh is preferred by this user
                  # users.users.pabloagn.shell = pkgs.zsh; # This is user-specific override
                };
              }

              # User config for host
              ({ lib, config, ... }: {
                # Override the default shell choices:
                mySystem.userShells = {
                  enable = [ "zsh" "fish" "bash" ]; # Customer wants Zsh, Fish, and Bash installed
                  defaultLoginShell = "zsh"; # Customer wants Zsh as the default login shell
                };

                mySystem.userTerminals = {
                  enable = [ "ghostty" "kitty" "wezterm" ];
                  default = "ghostty";
                };

                # Theme choices
                mySystem.theme = {
                  name = "phantom";
                  font.primary = "Inter";
                  font.monospace = "JetBrainsMono";
                  font.defaultSize = "10pt";
                };

                # Host profile choice
                mySystem.hostProfile = "headless-dev";
              })
            ];
          };

          "nixos-native" = nixpkgs.lib.nixosSystem {
            # ... similar structure ...
            modules = [
              # ... other modules ...
              # === CUSTOMER CHOICES FOR THIS "desktop-main" CAR ===
              ({ lib, config, ... }: {
                mySystem.userShells = {
                  enable = [ "fish" "bash" ]; # This customer only wants Fish and Bash
                  defaultLoginShell = "fish"; # Fish is their default
                };
                mySystem.theme.name = "srcl";
                # ... other theme choices ...
                # mySystem.hostProfile = "gui-desktop";
              })
            ];
          };
        };
      };
    };
}

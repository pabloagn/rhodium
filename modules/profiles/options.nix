# modules/profiles/options.nix

{ lib, config, pkgs, ... }:

let
  # Available choices (these should ideally be derived from actual module definitions or assets)
  # TODO: For now, hardcoded for clarity. Later, these can be populated dynamically.
  availableShells = [
    "zsh"
    "fish"
    "bash"
    "nushell"
  ];

  availableTerminals = [
    "ghostty"
    "kitty"
    "wezterm"
    "alacritty"
    "foot"
  ];

  availableEditors = [
    "helix"
    "neovim"
    "emacs"
    "vscode"
  ];

  availableWms = [
    "hyprland"
    "sway"
    "i3"
    "bspwm"
    "none"
  ]; # "none" for headless

  availableBars = [
    "waybar"
    "polybar"
    "eww"
    "none"
  ]; # "none" for headless or no bar

  availableThemes = lib.attrNames (
    import ../../assets/themes/definitions/default.nix);

  availableFontFamilies = lib.attrNames (
    import ../../assets/tokens/fonts/definitions.nix { inherit pkgs lib; }
  );
in
{
  options.mySystem = {
    # Host Capability Profile
    hostProfile = lib.mkOption {
      type = lib.types.enum [ "headless-dev" "gui-desktop" "server-minimal" ];
      default = "headless-dev";
      description = "Defines the primary role and capabilities of this host.";
      example = "gui-desktop";
    };

    # User-Level Preferences
    # For now, let's assume these are host-wide preferences that users on that host get.
    # TODO: More complex: move these into home-manager user profiles with overrides.

    userShells = {
      enable = lib.mkOption {
        type = lib.types.listOf (lib.types.enum availableShells);
        default = [ "zsh" ];
        description = "List of shells to install for users.";
        example = [ "zsh" "fish" ];
      };
      default = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum availableShells);
        default = "zsh";
        description = "Default shell for new users on this system (if not overridden by user config).";
      };
    };

    userTerminals = {
      enable = lib.mkOption {
        type = lib.types.listOf (lib.types.enum availableTerminals);
        default = [ "alacritty" ]; # A sensible default
        description = "List of terminal emulators to install.";
        example = [ "ghostty" "kitty" ];
      };
      default = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum availableTerminals);
        default = "alacritty";
        description = "Default terminal emulator (e.g., for xdg-terminal-exec).";
      };
    };

    userEditors = {
      enable = lib.mkOption {
        type = lib.types.listOf (lib.types.enum availableEditors);
        default = [ "neovim" ];
        description = "List of text editors to install.";
        example = [ "helix" "neovim" ];
      };
      # No 'default' editor option here as it's highly personal and app-dependent.
    };

    # --- DESKTOP SPECIFIC PREFERENCES (only relevant if hostProfile = "gui-desktop") ---
    desktop = {
      windowManager = lib.mkOption {
        type = lib.types.enum availableWms;
        default = "none"; # Default to none, host profile or user choice enables one
        description = "Preferred window manager for GUI sessions.";
      };
      statusBar = lib.mkOption {
        type = lib.types.enum availableBars;
        default = "none";
        description = "Preferred status bar for GUI sessions.";
      };
      # We already have mySystem.theme for colors/fonts
    };

    # --- HARDWARE SPECIFIC FLAGS (can be expanded) ---
    hardware = {
      amdGpu = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable AMD GPU specific configurations (e.g., drivers, Hyprland flags).";
      };
      nvidiaGpu = lib.mkOption {
        # Example
        type = lib.types.bool;
        default = false;
        description = "Enable NVIDIA GPU specific configurations.";
      };
    };
  };

  # Options Validation
  config = lib.mkMerge [
    (lib.mkIf (config.mySystem.hostProfile != "gui-desktop") {
      # If not a GUI desktop, certain desktop options should be 'none' or raise warnings/errors
      assertions = [
        {
          assertion = config.mySystem.desktop.windowManager == "none";
          message = "Window manager (${config.mySystem.desktop.windowManager}) selected for a non-GUI host profile (${config.mySystem.hostProfile}). Should be 'none'.";
        }
        {
          assertion = config.mySystem.desktop.statusBar == "none";
          message = "Status bar (${config.mySystem.desktop.statusBar}) selected for a non-GUI host profile (${config.mySystem.hostProfile}). Should be 'none'.";
        }
      ];
    })
    # Add more assertions:
    # - Ensure default shell is in enabled shells.
    # - Ensure default terminal is in enabled terminals.
    (lib.mkIf (config.mySystem.userShells.default != null && !(lib.elem config.mySystem.userShells.default config.mySystem.userShells.enable)) {
      assertions = [{
        assertion = false;
        message = "Default shell '${config.mySystem.userShells.default}' is not in the list of enabled shells: [${lib.concatStringsSep ", " config.mySystem.userShells.enable}]";
      }];
    })
    # TODO: Terminals
  ];
}

# modules/profiles/options.nix

{ lib, config, pkgs, ... }:

let
  # Available choices
  # ---------------------------------------
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
  ]; # "none" for headless

  availableFileManagers = [
    "dolphin"
    "nautilus"
    "thunar"
    "yazi"
    "lf"
    "nnn"
  ];

  availableNotificationDaemons = [
    "dunst"
    "mako"
  ];

  availableLaunchers = [
    "rofi"
    "wofi"
    "fuzzel"
    "anyrun"
  ];

  availableThemes = lib.attrNames (
    import ../../assets/themes/definitions/default.nix
  );

  availableFontFamilies = lib.attrNames (
    import ../../assets/tokens/fonts/definitions.nix { inherit pkgs lib; }
  );
in
{
  # -----------------------------------
  # User options
  # -----------------------------------
  options.mySystem = {

    # Host profile
    # -----------------------------------
    hostProfile = lib.mkOption {
      type = lib.types.enum [ "headless-dev" "tiling-desktop" "gui-desktop" "server-minimal" ];
      default = "tiling-desktop";
      description = "Primary role of this host (influences conditional module loading).";
    };

    # NEW: User Roles System
    # -----------------------------------
    userRoles = {
      users = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            description = lib.mkOption {
              type = lib.types.str;
              description = "User's full name or description";
            };
            shell = lib.mkOption {
              type = lib.types.package;
              description = "User's preferred shell";
              example = "pkgs.zsh";
            };
            roles = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              description = "List of roles assigned to the user";
              example = ''[ "admin" "developer" ]'';
            };
            hosts = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              description = "List of hosts this user should exist on";
              example = ''[ "nixos-wsl2" "nixos-native" ]'';
            };
          };
        });
        default = { };
        description = "User role definitions for the system";
      };

      availableRoles = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "admin" "developer" "desktop" ];
        description = "Available user roles in the system";
      };
    };

    # User shells
    # -----------------------------------
    userShells = {
      enable = lib.mkOption {
        type = lib.types.litOf (lib.types.enum availableShells);
        default = [ "bash" ]; # Factory standard: bash is always installed
        description = "List of shells to make available on the system.";
      };

      # User default login shell
      # -----------------------------------
      defaultLoginShell = lib.mkOption {
        type = lib.types.enum availableShells;
        default = "bash"; # Factory standard: bash is the default login shell
        description = "The default login shell for users on this system.";
      };

      # User terminals
      # -----------------------------------
      userTerminals = {
        enable = lib.mkOption {
          type = lib.types.listOf (lib.types.enum availableTerminals); # availableTerminals defined at top
          default = [ ]; # Default: no specific terminals installed by this option, only if requested
          description = "List of terminal emulators to install for general use.";
        };
        default = lib.mkOption {
          type = lib.types.nullOr (lib.types.enum availableTerminals);
          default = null; # No system-wide default terminal by this option alone
          description = "Preferred default terminal application.";
        };
      };

      # User editors
      # -----------------------------------
      userEditors = {
        enable = lib.mkOption {
          type = lib.types.listOf (lib.types.enum availableEditors);
          default = [ "neovim" ];
        };
      };

      desktop = {
        windowManager = lib.mkOption { type = lib.types.enum availableWms; default = "none"; };
        statusBar = lib.mkOption { type = lib.types.enum availableBars; default = "none"; };
        fileManager = lib.mkOption { type = lib.types.enum availableFileManagers; default = "nautilus"; }; # A common GUI default
        notificationDaemon = lib.mkOption { type = lib.types.enum availableNotificationDaemons; default = "dunst"; };
        launcher = lib.mkOption { type = lib.types.enum availableLaunchers; default = "rofi"; };
      };

      theme = {
        # Options for this already defined in modules/themes/options.nix
        # We just need to ensure modules/themes/options.nix populates its enums correctly
      };

      hardware = {
        amdGpu = lib.mkEnableOption "AMD GPU specific configurations";
        nvidiaGpu = lib.mkEnableOption "NVIDIA GPU specific configurations";
        # TODO: Add intelGpu etc. if needed
      };
    };
  };

  # -----------------------------------
  # Assertions
  # -----------------------------------
  config = {
    assertions = [
      {
        # Is default shell in enabled shells?
        assertion = lib.elem config.mySystem.userShells.defaultLoginShell config.mySystem.userShells.enable;
        message = "Default login shell '${config.mySystem.userShells.defaultLoginShell}' must be in enabled shells.";
      }
      {
        # Is default term in enabled terms?
        assertion = lib.elem config.mySystem.userTerminals.default config.mySystem.userTerminals.enable;
        message = "Default terminal '${config.mySystem.userTerminals.default}' must be in enabled terminals.";
      }
      (lib.mkIf (config.mySystem.hostProfile != "gui-desktop") {
        assertion = config.mySystem.desktop.windowManager == "none" &&
          config.mySystem.desktop.statusBar == "none" &&
          config.mySystem.desktop.launcher == "rofi";
        message = "For non-GUI host profiles, WM and StatusBar should be 'none'. Launcher can be CLI-friendly like rofi/fuzzel.";
      })
      (lib.mkIf (config.mySystem.hardware.amdGpu && config.mySystem.hardware.nvidiaGpu) {
        assertion = false; # Or handle this case by prioritizing one, for now, it's an error
        message = "Both AMD and NVIDIA GPU options are enabled. Please choose one or implement prioritization.";
      })
    ];
  };
}

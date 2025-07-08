{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.rhWidgets.astal;
in {
  options.rhWidgets.astal = {
    enable = mkEnableOption "Astal widgets";

    configDir = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to AGS config directory to symlink to ~/.config/ags";
    };

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional packages to add to AGS runtime";
    };
  };

  config = mkIf cfg.enable {
    # Import AGS home manager module
    imports = [
      inputs.ags.homeManagerModules.default
    ];

    # Configure AGS program
    programs.ags = {
      enable = true;
      configDir = cfg.configDir;
      extraPackages = with pkgs;
        [
          # Core astal libraries (astal3, astal4, astal-io included by default)
          inputs.ags.packages.${pkgs.system}.astal.battery
          inputs.ags.packages.${pkgs.system}.astal.network
          inputs.ags.packages.${pkgs.system}.astal.bluetooth
          inputs.ags.packages.${pkgs.system}.astal.tray
          inputs.ags.packages.${pkgs.system}.astal.mpris
          inputs.ags.packages.${pkgs.system}.astal.apps
          inputs.ags.packages.${pkgs.system}.astal.notifd

          # Additional utilities
          jq
          curl
          fzf
        ]
        ++ cfg.extraPackages;
    };

    # Add AGS CLI to environment
    home.packages = [
      inputs.ags.packages.${pkgs.system}.default
    ];
  };
}

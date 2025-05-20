# home/apps/browsers/zen.nix

{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.zen;

  hasZenBrowser = inputs ? zen-browser;

  system = pkgs.stdenv.hostPlatform.system;
in
{
  options.rhodium.home.apps.browsers.zen = {
    enable = mkEnableOption "Zen Browser";

    variant = mkOption {
      type = types.enum [ "specific" "generic" ];
      default = "specific";
      description = ''
        Which variant of Zen Browser to install.
        - "specific": Optimized for newer CPUs and kernels (same as 'default')
        - "generic": Maximizes compatibility with old CPUs and kernels
      '';
      example = "generic";
    };
  };

  config = mkIf (cfg.enable && hasZenBrowser) {
    home.packages =
      let

        hasPkgsForSystem = hasZenBrowser && inputs.zen-browser.packages ? ${system};

        zenPackage =
          if !hasPkgsForSystem then null
          else if cfg.variant == "specific" then inputs.zen-browser.packages.${system}.specific
          else if cfg.variant == "generic" then inputs.zen-browser.packages.${system}.generic
          else inputs.zen-browser.packages.${system}.default;
      in
      lib.optional (zenPackage != null) zenPackage;

    warnings = lib.optional (cfg.enable && hasZenBrowser && !(inputs.zen-browser.packages ? ${system}))
      "Zen browser packages not available for system ${system}";
  };
}

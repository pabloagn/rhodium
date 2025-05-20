# home/development/languages/r.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.r;
in
{
  options.rhodium.home.development.languages.r = {
    enable = mkEnableOption "Enable R development environment (Home Manager)";

    interpreter = mkOption {
      type = types.package;
      default = pkgs.R;
      description = "R language environment.";
    };

    languageServer = mkOption {
      type = types.nullOr types.package;
      default = pkgs.rPackages.languageserver;
      description = "R Language Server (rPackages.languageserver).";
    };

    linters = mkOption {
      type = types.listOf types.package;
      default = with pkgs.rPackages; [ lintr ];
      description = "Linters for R (e.g., rPackages.lintr).";
    };

    ideSupport = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Support packages for R IDEs.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ radian ];
      description = "Additional R-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.interpreter ]
      ++ (if cfg.languageServer != null then [ cfg.languageServer ] else [ ])
      ++ cfg.linters
      ++ cfg.ideSupport
      ++ cfg.extraTools;
  };
}

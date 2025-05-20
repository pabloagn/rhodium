# home/development/languages/julia.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.julia;
in
{
  options.rhodium.home.development.languages.julia = {
    enable = mkEnableOption "Enable Julia development environment (Home Manager)";

    runtime = mkOption {
      type = types.package;
      default = pkgs.julia-bin;
      description = "Julia runtime environment.";
      example = literalExpression "pkgs.julia_lts";
    };

    languageServerFromNix = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Julia Language Server packaged via Nix (if available and desired). Often managed via Julia's Pkg.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Julia-related tools installed via Nix.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.runtime ]
      ++ (if cfg.languageServerFromNix != null then [ cfg.languageServerFromNix ] else [ ])
      ++ cfg.extraTools;
  };
}

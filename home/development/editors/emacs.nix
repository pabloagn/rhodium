# home/development/editors/emacs.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.emacs;
in
{
  options.rhodium.home.development.editors.emacs = {
    enable = mkEnableOption "Rhodium's Emacs configuration";
    variant = mkOption {
      type = types.enum [ "emacs" "emacs-nox" ];
      default = "emacs";
      description = "The variant of Emacs to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let
        emacsPackage =
          if cfg.variant == "emacs" then pkgs.emacs
          else if cfg.variant == "emacs-nox" then pkgs.emacs-nox
          else pkgs.emacs;
      in
      [ emacsPackage ];
  };
}

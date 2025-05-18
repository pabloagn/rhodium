# home/development/editors/emacs.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.emacs;
in
{
  options.rhodium.development.editors.emacs = {
    enable = mkEnableOption "Rhodium's Emacs configuration";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      # package = pkgs.emacs-nox;
    };
  };
}

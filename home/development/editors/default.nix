# home/development/editors/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors;
in
{
  imports = [
    ./cursor.nix
    ./emacs.nix
    ./helix.nix
    ./kate.nix
    ./mousepad.nix
    ./nvim.nix
    ./rstudio.nix
    ./vscode.nix
    ./lapce.nix
    ./zed.nix
  ];

  options.rhodium.home.development.editors = {
    enable = mkEnableOption "Rhodium's code editors";
  };

  config = mkIf cfg.enable {
    rhodium.home.development.editors = {
      cursor.enable = false;
      emacs.enable = false;
      helix.enable = true;
      kate.enable = false;
      mousepad.enable = true;
      nvim.enable = true;
      rstudio.enable = true;
      vscode = {
        enable = true;
        variant = "vscode";
      };
      lapce.enable = false;
      zed.enable = true;
    };
  };
}

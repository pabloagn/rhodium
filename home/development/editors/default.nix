# home/development/editors/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors;
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
  ];

  options.rhodium.development.editors = {
    enable = mkEnableOption "Rhodium's code editors";
  };

  config = mkIf cfg.enable {
    home.development.editors.cursor.enable = true;
    home.development.editors.emacs.enable = true;
    home.development.editors.helix.enable = true;
    home.development.editors.kate.enable = true;
    home.development.editors.mousepad.enable = true;
    home.development.editors.nvim.enable = true;
    home.development.editors.rstudio.enable = true;
    home.development.editors.vscode.enable = true;
  };
}

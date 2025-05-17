# home/development/editors/default.nix
{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors;
in
{
  imports = [
    ./helix.nix
    ./nvim.nix
    ./emacs.nix
    ./mousepad.nix
    ./rstudio.nix
    ./vscode.nix
    ./vscodium.nix
    ./cursor.nix
    ./kate.nix
  ];

  options.rhodium.development.editors = {
    enable = mkEnableOption "Rhodium's code editors";
  };

  config = mkIf cfg.enable {
  };
}

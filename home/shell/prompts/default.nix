# home/shell/prompts/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./starship.nix
  ];

  options.rhodium.shell.prompts = {
    enable = mkEnableOption "Prompts";
  };

  config = mkIf cfg.enable {
    rhodium.shell.prompts.starship.enable = true;
  };
}

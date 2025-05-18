# home/shell/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./shells
    ./prompts
    ./common
  ];

  options.rhodium.shell = {
    enable = mkEnableOption "Rhodium's shell configuration";
  };

  config = mkIf cfg.enable {
    rhodium.shell.shells.default.enable = true;
    rhodium.shell.prompts.default.enable = true;
  };
}

# home/shell/shells/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./nushell.nix
    ./zsh.nix
    ./ion.nix
  ];

  options.rhodium.shell = {
    enable = mkEnableOption "Shell";
  };

  config = mkIf cfg.enable {
    rhodium.shell.shells.bash.enable = true;
    rhodium.shell.shells.fish.enable = true;
    rhodium.shell.shells.nushell.enable = true;
    rhodium.shell.shells.zsh.enable = true;
    rhodium.shell.shells.ion.enable = true;
  };
}

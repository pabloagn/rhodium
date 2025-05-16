# home/shell/shells/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./zsh.nix
    ./bash.nix
    ./fish.nix
  ];
}

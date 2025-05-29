{ config, pkgs, ... }:

let
  aliases = import ./common/aliases.nix;
  functions = import ./common/functions.nix;
in
{
  programs.nushell = {
    enable = true;
    shellAliases = aliases;
  };
}

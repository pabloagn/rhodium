{ pkgs, ... }:

let
  aliases = import ./common/aliases.nix;
  functions = import ./common/functions.nix;
in
{
  programs.fish = {
    enable = true;
    shellAliases = aliases;
    functions = functions;
  };
}

{ config, pkgs, ... }:
{
  aliases = import ./aliases.nix { inherit config; };
  functions = import ./functions.nix { };
}

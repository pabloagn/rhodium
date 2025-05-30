{ config, ... }:
{
  aliases = import ./aliases.nix { inherit config; };
  functions = import ./functions.nix { inherit config; };
}

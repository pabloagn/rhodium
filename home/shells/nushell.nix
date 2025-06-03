{ config, pkgs, ... }:

let
  common = import ./common { inherit config pkgs; };
in
{
  programs.nushell = {
    enable = true;
    # shellAliases = common.aliases; # TODO: Verify this works properly
  };
}

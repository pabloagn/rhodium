{ config, ... }:

let
  common = import ./common { inherit config; };
in
{
  programs.nushell = {
    enable = true;
    # shellAliases = common.aliases; # TODO: Verify this works properly
  };
}

{ ... }:

let
  common = import ../common { };
in
{
  programs.fish = {
    shellAliases = common.aliases;
  };
}

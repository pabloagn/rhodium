{ pkgs, config, ... }:

let
  common = import ./common { inherit config; };
in
{
  programs.fish = {
    enable = true;
    shellAliases = common.aliases; # TODO: Caused problems
    # functions = common.functions; # TODO: Check how to actually do this
  };
}

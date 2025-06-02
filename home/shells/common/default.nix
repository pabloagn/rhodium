{ config, pkgs, ... }:
{
  aliases = import ./aliases.nix { inherit config; };
  functions = import ./functions.nix { };

  home.packages = with pkgs; [
    atuin # Revolutionary shell history management
    mcfly # Intelligent command history search
    skim # Alternative to fzf, sometimes faster
  ];
}

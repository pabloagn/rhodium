# home/default.nix

{ lib, config, pkgs, flakeOutputs, ... }:

let
  flakeRoot = flakeOutputs.self;
in
{
  # This module provides foundational settings for any user.

  # Global User Scripts
  home.file.".local/bin" = {
    source = "${flakeRoot}/scripts";
    recursive = true;
    executable = true;
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Other base settings:
  # programs.git.enable = true; # (user/email set in user-specific file)
  # programs.zsh.enable = true; # Base Zsh setup
  home.stateVersion = "24.11";
}

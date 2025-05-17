# home/default.nix

{ lib, config, pkgs, flakeOutputs, ... }:

let
  flakeRoot = flakeOutputs.self;
in
{
  # This module provides foundational settings for any user.

  # Other base settings:
  # programs.git.enable = true; # (user/email set in user-specific file)
  # programs.zsh.enable = true; # Base Zsh setup
  home.stateVersion = "24.11";
}

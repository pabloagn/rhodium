# users/user-0001/default.nix

{ config, pkgs, lib, inputs, flakeOutputs, pkgs-unstable, userData, ... }:

{
  imports = [
    flakeOutputs.rhodium.home.default
  ];

  # Profile
  # ------------------------------------
  home.username = userData.username;
  home.homeDirectory = "/home/${userData.username}";

  # Options
  # ------------------------------------
  rhodium = {
  };

  # State
  # ------------------------------------
  home.stateVersion = "24.11";
}

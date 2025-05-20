# users/user-0001/default.nix

{ config, pkgs, lib, userData, rhodium,... }:

{
  imports = [
    # Minimal defaults
    ../../home/default.nix

    # Profiles
    ../../home/profiles/developer.nix
  ];
  home.username = userData.username;
  home.homeDirectory = "/home/${userData.username}";
}

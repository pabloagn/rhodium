# home/default.nix

{ lib, config, pkgs, ... }:
{
  imports = [
    ./apps/default.nix
    ./desktop/default.nix
    ./development/default.nix
    ./environment/default.nix
    ./security/default.nix
    ./shell/default.nix
    ./system/default.nix
  ];

  home.stateVersion = "24.11";
}

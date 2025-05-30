# data/users/extras/default.nix

{ config, lib, pkgs, userPreferences, ... }:

{
  imports = [
    (import ./apps.nix)
    (import ./bookmarks.nix)
    (import ./profiles.nix)
  ];
}

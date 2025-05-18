# modules/core/security/default.nix

{ config, lib, pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
}

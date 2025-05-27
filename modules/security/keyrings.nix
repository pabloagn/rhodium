{ config, pkgs, ... }:

{
  # Gnome Keyring required by Proton Bridge
  services.gnome.gnome-keyring.enable = true;
}

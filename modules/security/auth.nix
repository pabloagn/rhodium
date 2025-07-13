{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    polkit_gnome
    cmd-polkit # Client for interacting with polkit
  ];

  security.polkit.enable = true;
}

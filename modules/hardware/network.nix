{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Networking
    firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Graphical interface for firewalld
    networkmanager # Network configuration & management CLI tool
    networkmanagerapplet # GUI for setting up WiFi & Bluetooth
    wireguard-tools # Tools for the WireGuard secure network tunnel
    wireguard-ui # Web user interface to manage WireGuard setup
    openresolv # Tool to interact with resolv.conf
  ];
  # networking = {
  #   firewall.checkReversePath = false; # HACK: Required for VPN
  # };

  networking = {
    firewall.checkReversePath = lib.mkForce "loose"; # HACK: Required for VPN
  };
}

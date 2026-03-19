{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Networking
    firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Graphical interface for firewalld
    networkmanager # Network configuration & management CLI tool
    networkmanager-openvpn # OpenVPN plugin for NetworkManager (required by ProtonVPN)
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
    networkmanager.plugins = with pkgs; [
      networkmanager-openvpn # Required by ProtonVPN GUI
    ];
  };
}

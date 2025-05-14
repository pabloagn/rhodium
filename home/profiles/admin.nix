# home/profiles/admin.nix

{ config, lib, pkgs, ... }:

{
  # Admin-specific home configuration
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "server" = {
        hostname = "example.com";
        user = "admin";
      };
    };
  };

  home.packages = with pkgs; [
    # Admin tools
    htop
    iotop
    dstat
    nmap
    tcpdump
  ];
}

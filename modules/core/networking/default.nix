# modules/core/networking/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.core.networking;
in
{
  options.rhodium.system.core.networking = {
    enable = mkEnableOption "Rhodium networking configuration";

    useDHCP = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use DHCP by default for network interfaces.";
    };
    networkmanager.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable NetworkManager service.";
    };
    firewall.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the default NixOS firewall.";
    };
    networkManagerApplet.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the NetworkManager applet system tray icon.";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      inherit (cfg) useDHCP;
      networkmanager.enable = cfg.networkmanager.enable;
      firewall.enable = cfg.firewall.enable;
    };

    environment.systemPackages = mkIf cfg.networkManagerApplet.enable [
      pkgs.networkmanagerapplet
    ];
  };
}

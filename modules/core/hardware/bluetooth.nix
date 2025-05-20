# modules/core/hardware/bluetooth.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.bluetooth;
in
{
  options.rhodium.system.hardware.bluetooth = {
    enable = mkEnableOption "Rhodium Bluetooth configuration";

    package.manager = mkOption {
      type = types.nullOr types.package;
      default = pkgs.blueman;
      defaultText = literalExpression "pkgs.blueman";
      description = "Package for a Bluetooth management GUI. Set to null to disable.";
      example = literalExpression "pkgs.gnome.gnome-bluetooth or null";
    };

    package.networkManagerApplet = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to install networkmanagerapplet (includes Bluetooth applet for some DEs).";
    };

    package.utils = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to install bluez-utils for command-line utilities like bluetoothctl.";
    };

    powerOnBoot = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to power on the Bluetooth adapter on boot.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      (optional (cfg.package.manager != null) cfg.package.manager)
      ++ (optional cfg.package.networkManagerApplet pkgs.networkmanagerapplet)
      ++ (optional cfg.package.utils pkgs.bluez-utils);

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;
    };
  };
}

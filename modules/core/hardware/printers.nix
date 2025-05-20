# modules/core/hardware/printers.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.printers;
in
{
  options.rhodium.system.hardware.printers = {
    enable = mkEnableOption "Rhodium printing services (CUPS) configuration";

    drivers.gutenprint = mkOption {
      type = types.bool;
      default = false;
      description = "Install Gutenprint drivers for a wide range of printers.";
    };

    drivers.hplip = mkOption {
      type = types.bool;
      default = false;
      description = "Install HPLIP drivers and utilities for HP printers. May require enabling 'services.hp.enable'.";
    };

    package.system-config-printer = mkOption {
      type = types.bool;
      default = false;
      description = "Install system-config-printer GUI for managing printers.";
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;

    environment.systemPackages =
      (optional cfg.drivers.gutenprint pkgs.gutenprintBin)
      ++ (optional cfg.drivers.hplip pkgs.hplip)
      ++ (optional cfg.package.system-config-printer pkgs.system-config-printer);
  };
}

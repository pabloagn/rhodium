# home/system/monitoring/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.monitoring;
in
{
  options.rhodium.system.monitoring = {
    enable = mkEnableOption "System monitoring tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      acpi
      bottom
      v4l-utils
      upower
    ];
  };
}

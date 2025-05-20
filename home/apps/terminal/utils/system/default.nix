# home/apps/terminal/utils/system/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.system;
  categoryName = "system";

  packageSpecs = [
    { name = "btop"; pkg = pkgs.btop; description = "Modern resource monitor with advanced visuals"; }
    { name = "htop"; pkg = pkgs.htop; description = "Interactive process viewer (classic)"; }
    { name = "bottom"; pkg = pkgs.bottom; description = "Modern system monitor with beautiful graphs"; }
    { name = "glances"; pkg = pkgs.glances; description = "Cross-platform system monitoring tool"; }
    { name = "disfetch"; pkg = pkgs.disfetch; description = "Minimal system info display"; }
    { name = "onefetch"; pkg = pkgs.onefetch; description = "Git repository summary with language stats"; }
    { name = "hwinfo"; pkg = pkgs.hwinfo; description = "Comprehensive hardware information"; }
    { name = "inxi"; pkg = pkgs.inxi; description = "Full system information script"; }
    { name = "dmidecode"; pkg = pkgs.dmidecode; description = "DMI table decoder for hardware details"; }
    { name = "lshw"; pkg = pkgs.lshw; description = "Hardware lister"; }
    { name = "pciutils"; pkg = pkgs.pciutils; description = "PCI utilities"; }
    { name = "usbutils"; pkg = pkgs.usbutils; description = "USB utilities"; }
    { name = "bmon"; pkg = pkgs.bmon; description = "Bandwidth monitor with visual graphs"; }
    { name = "iftop"; pkg = pkgs.iftop; description = "Network traffic monitor by interface"; }
    { name = "vnstat"; pkg = pkgs.vnstat; description = "Network traffic monitor and database"; }
    { name = "bandwhich"; pkg = pkgs.bandwhich; description = "Terminal bandwidth utilization tool"; }
    { name = "mtr"; pkg = pkgs.mtr; description = "Traceroute and network diagnostic tool"; }
  ];
in
{
  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}

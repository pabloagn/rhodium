# home/apps/terminal/utils/system/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    # System Monitoring
    { name = "btop"; pkg = pkgs.btop; description = "Modern resource monitor with advanced visuals"; }
    { name = "htop"; pkg = pkgs.htop; description = "Interactive process viewer (classic)"; }
    { name = "bottom"; pkg = pkgs.bottom; description = "Modern system monitor with beautiful graphs"; }
    { name = "glances"; pkg = pkgs.glances; description = "Cross-platform system monitoring tool"; }

    # System Information
    { name = "disfetch"; pkg = pkgs.disfetch; description = "Minimal system info display"; }

    # PENDING ADD SUBCATEGORIES (FROM HERE DOWNWARDS)
    { name = "hwinfo"; pkg = pkgs.hwinfo; description = "Comprehensive hardware information"; }
    { name = "inxi"; pkg = pkgs.inxi; description = "Full system information script"; }
    { name = "dmidecode"; pkg = pkgs.dmidecode; description = "DMI table decoder for hardware details"; }
    { name = "lshw"; pkg = pkgs.lshw; description = "Hardware lister"; }
    { name = "pciutils"; pkg = pkgs.pciutils; description = "PCI utilities"; }
    { name = "usbutils"; pkg = pkgs.usbutils; description = "USB utilities"; }
    { name = "bmon"; pkg = pkgs.bmon; description = "Bandwidth monitor with visual graphs"; }
    { name = "mtr"; pkg = pkgs.mtr; description = "Traceroute and network diagnostic tool"; }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}

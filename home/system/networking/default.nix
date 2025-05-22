# home/system/networking/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "filezilla";
      pkg = pkgs.filezilla;
      description = "A free, open-source, cross-platform FTP, FTPS and SFTP client.";
    }
    {
      name = "freerdp3";
      pkg = pkgs.freerdp3;
      description = "A free implementation of the Remote Desktop Protocol (RDP).";
    }
    {
      name = "remmina";
      pkg = pkgs.remmina;
      description = "A remote desktop client for various network protocols.";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} configurations";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}

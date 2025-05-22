# home/apps/productivity/documents/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
  packageSpecs = [
    {
      name = "okular";
      pkg = pkgs.okular;
      description = "Okular document viewer";
    }
    {
      name = "texmaker";
      pkg = pkgs.texmaker;
      description = "Texmaker LaTeX editor";
    }
    {
      name = "zathura";
      pkg = pkgs.zathura;
      description = "Zathura PDF viewer";
    }
    {
      name = "paperless-ngx";
      pkg = pkgs.paperless-ngx;
      description = "Paperless-ngx document management system";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}

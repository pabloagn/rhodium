# home/apps/terminal/utils/finders/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;

let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    {
      name = "fd";
      pkg = pkgs.fd;
      description = "Fast, modern alternative to find";
    }
    {
      name = "fzf";
      pkg = pkgs.fzf;
      description = "Command-line fuzzy finder";
    }
    {
      name = "ripgrep";
      pkg = pkgs.ripgrep;
      description = "Search tool like grep, but faster";
    }
    {
      name = "ripgrep-all";
      pkg = pkgs.ripgrep-all;
      description = "Search tool like ripgrep, but all inclusive";
    }
    {
      name = "plocate";
      pkg = pkgs.plocate;
      description = "Updated locate command";
    }
    {
      name = "ag";
      pkg = pkgs.ag;
      description = "A code-searching tool similar to ack, but faster";
    }
    {
      name = "ugrep";
      pkg = pkgs.ugrep;
      description = "A faster, user-friendly and compatible alternative to grep";
    }
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

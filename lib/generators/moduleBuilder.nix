{ lib, pkgs }:

{ path, description, packages }:

let
  getCfg = config: lib.attrsets.getAttrFromPath path config;
in
{ config, ... }:

let
  cfg = getCfg config;
in
{
  options = lib.attrsets.setAttrByPath path {
    enable = lib.mkEnableOption description;
  };

  config = lib.mkIf cfg.enable {
    home.packages = packages;
  };
}


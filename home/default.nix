# home/default.nix

{ lib, config, pkgs, _haumea, rhodium, rhodiumLib, ... }:


let
  cfg = lib.getAttrFromPath _haumea.configPath config;
in
{
  options = lib.setAttrByPath _haumea.configPath {
    enable = lib.mkEnableOption "Rhodium's Home Environment" // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.11";
  };
}

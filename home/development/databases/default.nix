# home/development/databases/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.databases;
in
{
  options.rhodium.home.development.databases = {
    enable = mkEnableOption "Rhodium's database tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      redis
      postgresql
      dbeaver-bin
    ];
  };
}

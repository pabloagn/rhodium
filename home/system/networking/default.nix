# home/system/networking/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.networking;
in
{
  options.rhodium.system.networking = {
    enable = mkEnableOption "Networking tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      filezilla
      freerdp3
      remmina
    ];
  };
}

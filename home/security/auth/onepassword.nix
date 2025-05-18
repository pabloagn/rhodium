# home/security/auth/onepassword.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.auth.onepassword;
in
{
  options.rhodium.security.auth.onepassword = {
    enable = mkEnableOption "Rhodium's 1password configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      _1password-gui
      _1password-cli
    ];
  };
}

# home/security/auth/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.auth;
in
{
  imports = [
    ./ssh.nix
    ./onepassword.nix
    ./sops.nix
  ];

  options.rhodium.security.auth = {
    enable = mkEnableOption "Rhodium's authentication configuration";
  };

  config = mkIf cfg.enable {
    rhodium.security.auth.ssh.enable = true;
    rhodium.security.auth.onepassword.enable = true;
    rhodium.security.auth.sops.enable = true;

    home.packages = with pkgs; [
      pass
      pass-wayland
      gnupg
      gnome-keyring
      gnutls
    ];
  };
}

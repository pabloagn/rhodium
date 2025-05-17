# home/security/auth/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.auth;
in
{
  options.rhodium.security.auth = {
    enable = mkEnableOption "Rhodium's authentication configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      pass
      gnupg
      gnome-keyring
      sops
      _1password-gui
    ];

    # SSH Per-Host Settings
    programs.ssh.matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = "$HOME/.ssh/nixos";
      };
    };
  };
}

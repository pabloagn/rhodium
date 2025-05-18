# home/security/auth/ssh.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.auth.ssh;
in
{
  options.rhodium.security.auth.ssh = {
    enable = mkEnableOption "Rhodium's SSH configuration";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          hostname = "github.com";
          identityFile = "$HOME/.ssh/nixos";
        };
      };
    };
  };
}

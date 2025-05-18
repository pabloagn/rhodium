# apps/terminal/utils/bat.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal.utils.bat;
in
{
  options.rhodium.apps.terminal.utils.bat = {
    enable = mkEnableOption "Rhodium's Bat configuration";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "/Catppuccin-mocha.tmTheme";
        };
      };
      config = {
        style = "plain";
        theme = "catppuccin-mocha";
      };
    };
  };
}

# home/apps/terminal/utils/previewers/bat.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    programs.bat = {
      enable = true;
      themes = {
        # TODO:: Convert to local sourcing
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

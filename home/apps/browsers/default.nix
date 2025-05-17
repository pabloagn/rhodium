# home/apps/browsers/default.nix

# TODO: pending to add zen (comes from flake directly)

{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.rhodium.apps.browsers;
in
{
  imports = [
    ./firefox.nix
  ];

  options.rhodium.apps.browsers = {
    enable = mkEnableOption "Web browsers";

    brave = {
      enable = mkEnableOption "Brave Browser";
    };

    librewolf = {
      enable = mkEnableOption "Librewolf Browser";
    };

    tor = {
      enable = mkEnableOption "Tor Browser";
    };

    qutebrowser = {
      enable = mkEnableOption "Qutebrowser";
    };

    chrome = {
      enable = mkEnableOption "Google Chrome";
    };

    chromium = {
      enable = mkEnableOption "Chromium";
    };

    w3m = {
      enable = mkEnableOption "w3m terminal browser";
    };

    zen = {
      enable = mkEnableOption "Zen Browser";
      version = mkOption {
        type = types.enum [ "default" "specific" "generic" ];
        default = "default";
        description = "Zen Browser package variant (default/specific or generic)";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.optional cfg.brave pkgs.brave)
      (lib.optional cfg.w3m pkgs.w3m)
      (lib.optional cfg.librewolf pkgs.librewolf)
      (lib.optional cfg.tor pkgs.tor-browser-bundle-bin)
      (lib.optional cfg.qutebrowser pkgs.qutebrowser)
      (lib.optional cfg.chrome pkgs.google-chrome)
      (lib.optional cfg.chromium pkgs.chromium)
      (mkIf cfg.zen.enable (
        let
          selectedZen =
            if cfg.zen.version == "generic"
            then inputs.zen-browser.packages.${pkgs.system}.generic
            else inputs.zen-browser.packages.${pkgs.system}.default;
        in [ selectedZen ]
      ))
    ];
  };
}

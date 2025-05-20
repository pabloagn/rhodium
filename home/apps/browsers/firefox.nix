# home/apps/browsers/firefox.nix

{ config, lib, pkgs, pkgsUnstable ? pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.firefox;
in
{
  options.rhodium.home.apps.browsers.firefox = {
    enable = mkEnableOption "Firefox browser";
    variant = mkOption {
      type = types.enum [ "stable" "devedition" "nightly" "esr" ];
      default = "devedition";
      description = ''
        Which variant of Firefox to install.
        - "stable": Standard Firefox release from 'pkgs'.
        - "stable-unwrapped": Unwrapped Firefox release from 'pkgs'.
        - "devedition": Firefox Developer Edition from 'pkgsUnstable' (or 'pkgs' if pkgsUnstable not provided).
        - "devedition-unwrapped": Unwrapped Firefox Developer Edition from 'pkgs'.
        - "nightly": Firefox Nightly builds from 'pkgsUnstable' (or 'pkgs').
        - "esr": Firefox Extended Support Release from 'pkgs'.
        - "beta": Firefox Beta builds from 'pkgs'.
        - "beta-unwrapped": Unwrapped Firefox Beta builds from 'pkgs'.
      '';
      example = "stable";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let
        firefoxPackage =
          if cfg.variant == "stable" then pkgs.firefox
          else if cfg.variant == "stable-unwrapped" then pkgs.firefox-unwrapped
          else if cfg.variant == "devedition" then pkgsUnstable.firefox-devedition
          else if cfg.variant == "devedition-unwrapped" then pkgsUnstable.firefox-devedition-unwrapped
          else if cfg.variant == "nightly" then pkgsUnstable.firefox-nightly
          else if cfg.variant == "esr" then pkgs.firefox-esr
          else if cfg.variant == "beta" then pkgs.firefox-beta
          else if cfg.variant == "beta-unwrapped" then pkgs.firefox-beta-unwrapped
          else pkgs.firefox;
      in
      [ firefoxPackage ];
  };
}

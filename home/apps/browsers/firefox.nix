# home/apps/browsers/firefox.nix

{ lib, config, pkgs, pkgs-unstable, _haumea, rhodiumLib, ... }:

/*
  To install Firefox:
  1. Enable the main Firefox module:
   rhodium.home.apps.browsers.firefox.enable = true;
  2. Then, enable specific variants you want to install, for example:
   rhodium.home.apps.browsers.firefox.stable.enable = true;
   rhodium.home.apps.browsers.firefox.devedition.enable = true;
*/

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  variantSpecs = {
    stable = {
      pkg = pkgs.firefox;
      description = "Firefox Stable: Standard release from 'pkgs'.";
    };
    stable-unwrapped = {
      pkg = pkgs.firefox-unwrapped;
      description = "Firefox Stable Unwrapped: Unwrapped release from 'pkgs'.";
    };
    devedition = {
      pkg = pkgs-unstable.firefox-devedition;
      description = "Firefox Developer Edition: From 'pkgs-unstable'.";
    };
    devedition-unwrapped = {
      pkg = pkgs-unstable.firefox-devedition-unwrapped;
      description = "Firefox Developer Edition Unwrapped: From 'pkgs-unstable'.";
    };
    nightly = {
      pkg = pkgs-unstable.firefox-nightly;
      description = "Firefox Nightly: Bleeding edge builds from 'pkgs-unstable'.";
    };
    esr = {
      pkg = pkgs.firefox-esr;
      description = "Firefox ESR: Extended Support Release from 'pkgs'.";
    };
    beta = {
      pkg = pkgs.firefox-beta;
      description = "Firefox Beta: Beta builds from 'pkgs'.";
    };
    beta-unwrapped = {
      pkg = pkgs.firefox-beta-unwrapped;
      description = "Firefox Beta Unwrapped: Unwrapped beta builds from 'pkgs'.";
    };
  };
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        hasDesktop = true;
        defaultEnable = false;
      }
    //
    lib.mapAttrs
      (variantName: spec: {
        enable = mkEnableOption spec.description // { default = false; };
      })
      variantSpecs
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = lib.flatten (
      lib.mapAttrsToList
        (variantName: spec:
          lib.optional (cfg.${variantName}.enable or false) spec.pkg
        )
        variantSpecs
    );
  };
}

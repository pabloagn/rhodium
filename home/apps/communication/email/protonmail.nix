# home/apps/communication/email/protonmail.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

/*
  To enable ProtonMail applications:
    rhodium.home.apps.communication.email.protonmail.enable = true;

  To enable optional components like Peroxide:
    rhodium.home.apps.communication.email.protonmail.peroxide.enable = true;
*/

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
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
    {
      peroxide = {
        enable = mkEnableOption "Peroxide (alternative command-line Proton Mail Bridge)" // { default = false; };
      };
      hydroxide = {
        enable = mkEnableOption "Hydroxide (third-party command-line Proton Mail Bridge)" // { default = false; };
      };
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages =
      let
        basePackages = with pkgs; [
          protonmail-bridge
          protonmail-bridge-gui
          protonmail-desktop
        ];
        optionalPackages = with pkgs; [ ]
          ++ lib.optional (cfg.peroxide.enable or false) peroxide
          ++ lib.optional (cfg.hydroxide.enable or false) hydroxide;
      in
      basePackages ++ optionalPackages;
  };
}

# home/apps/communication/messaging/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "signal";
      pkg = pkgs.signal-desktop;
      description = "Signal Desktop private messenger";
    }
    {
      name = "whatsapp";
      pkg = pkgs.whatsapp-for-linux;
      description = "WhatsApp Desktop client (unofficial or wrapper)";
    }
    {
      name = "telegram";
      pkg = pkgs.telegram-desktop;
      description = "Telegram Desktop messenger";
    }
    {
      name = "slack";
      pkg = pkgs.slack;
      description = "Slack collaboration hub";
    }
    {
      name = "teams";
      # pkgs.teams or pkgs.teams-for-linux
      pkg = pkgs.teams;
      description = "Microsoft Teams client";
    }
    {
      name = "zoom";
      pkg = pkgs.zoom-us;
      description = "Zoom video conferencing client";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's communication ${categoryName} applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}

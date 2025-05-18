# home/apps/desktop/firefox-profiles.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.desktop.firefoxProfiles;
  defs = import ../../lib/desktop-definitions.nix { inherit lib config pkgs; };
in
{
  options.rhodium.apps.desktop.firefoxProfiles = {
    enable = mkEnableOption "Desktop Firefox Profiles";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [

      # Firefox Profile - Personal
      (makeDesktopItem {
        name = "firefox-personal";
        desktopName = "Firefox Personal";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with Personal profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Media
      (makeDesktopItem {
        name = "firefox-media";
        desktopName = "Firefox Media";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Media ${firefoxNewWindow} %u";
        icon = logos.firefox_media;
        comment = "Launch Firefox with Media profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Solenoid Labs
      (makeDesktopItem {
        name = "firefox-solenoidlabs";
        desktopName = "Firefox Solenoid Labs";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P SolenoidLabsPablo ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with Solenoid Labs profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - United Kingdom
      (makeDesktopItem {
        name = "firefox-uk";
        desktopName = "Firefox UK";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with UK profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Academic
      (makeDesktopItem {
        name = "firefox-academic";
        desktopName = "Firefox Academic";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Academic ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with Academic profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Bsogood
      (makeDesktopItem {
        name = "firefox-bsogood";
        desktopName = "Firefox Bsogood";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Bsogood ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with Bsogood profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Phantom
      (makeDesktopItem {
        name = "firefox-phantom";
        desktopName = "Firefox Phantom";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P TheHumanPalace ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with the Phantom profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - GenAI
      (makeDesktopItem {
        name = "firefox-genai";
        desktopName = "Firefox GenAI Dev";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P GenAI ${firefoxNewWindow} %u";
        icon = logos.firefox;
        comment = "Launch Firefox with the GenAI profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Profile - Private
      (makeDesktopItem {
        name = "firefox-private";
        desktopName = "Firefox Private";
        genericName = "${defs.genericStrings.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Private ${firefoxNewWindow} %u";
        icon = logos.firefox_private;
        comment = "Launch Firefox with custom Private profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Mode - Incognito
      (makeDesktopItem {
        name = "firefox-incognito";
        desktopName = "Firefox Incognito";
        genericName = "${defs.genericStrings.name.appMode}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} %u --private-window";
        icon = logos.firefox;
        comment = "Launch Firefox with Incognito mode.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })
    ];
  };
}

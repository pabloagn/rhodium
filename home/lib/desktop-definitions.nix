# home/lib/desktop-definitions.nix

{ lib, config, pkgs, inputs ? { } }:

with lib;
let
  logos = import ../../lib/logos.nix { inherit lib config pkgs; };
  terminal = config.home.sessionVariables.TERMINAL or "kitty";
  editor = config.home.sessionVariables.EDITOR or "nano";
  visual = config.home.sessionVariables.VISUAL or "code";

  firefoxPackage = pkgs.firefox;
  zenPackage =
    if inputs ? "zen-browser" && inputs.zen-browser.packages ? ${pkgs.stdenv.hostPlatform.system}
    then inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    else pkgs.zenith or null;

  browserNewWindowArg = "-new-window";

  genericStrings = {

    prefix = {
      app = "App";
      webApp = "Web App";
    };

    suffix = {
      textEditor = "Text Editor";
      imageViewer = "Image Viewer";
      webBrowser = "Web Browser";
      profile = "Profile";
      mode = "Mode";
    };

    profiles = {
      personal = "Personal";
      media = "Media";
      uk = "United Kingdom";
      academic = "Academic";
      bsogood = "Bsogood";
      phantom = "Phantom";
      genai = "GenAI";
      private = "Private";
      solenoidLabs = "Solenoid Labs";
    };

    name = {
      appEditor = "${generic.prefix.app} - ${generic.suffix.textEditor}";
      appImageViewer = "${generic.prefix.app} - ${generic.suffix.imageViewer}";
      appWebBrowser = "${generic.prefix.app} - ${generic.suffix.webBrowser}";
      appProfile = "${generic.prefix.app} - ${generic.suffix.profile}";
      webAppPersonal = "${generic.prefix.webApp} - ${generic.profiles.personal}";
      webAppMedia = "${generic.prefix.webApp} - ${generic.profiles.media}";
      webAppUk = "${generic.prefix.webApp} - ${generic.profiles.uk}";
      webAppAcademic = "${generic.prefix.webApp} - ${generic.profiles.academic}";
      webAppBsogood = "${generic.prefix.webApp} - ${generic.profiles.bsogood}";
      webAppPhantom = "${generic.prefix.webApp} - ${generic.profiles.phantom}";
      webAppGenai = "${generic.prefix.webApp} - ${generic.profiles.genai}";
      webAppPrivate = "${generic.prefix.webApp} - ${generic.profiles.private}";
      webAppSolenoidLabs = "${generic.prefix.webApp} - ${generic.profiles.solenoidLabs}";
    };
  };

  defaultWebBookmarkCategories = [ "Network" "WebBrowser" ];
  defaultWebBookmarkMimeTypes = [ "text/html" "text/xml" ];

in
{
  inherit
    logos terminal editor visual
    firefoxPackage zenPackage browserNewWindowArg
    genericStrings
    defaultWebBookmarkCategories defaultWebBookmarkMimeTypes;
}

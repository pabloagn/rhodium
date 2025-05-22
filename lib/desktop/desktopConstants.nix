# lib/desktop/desktopConstants.nix

{ lib, pkgs, inputs ? { }, paths, config }:

with lib;
let
  mkLogoPath = logoFileName: "${paths.assets.logos}/${logoFileName}";
in
{
  explicitLogoMap = {
    /*
      Explicitly defined logos for specific apps
      Use whenever convention is not enough
    */
    "firefox_general" = mkLogoPath "firefox_general.png";
    "firefox_media" = mkLogoPath "firefox_media.png";
    "firefox_private" = mkLogoPath "firefox_private.png";
    "youtube" = mkLogoPath "youtube.png";
    "linear" = mkLogoPath "linear.png";
    "github" = mkLogoPath "github.png";
    "neovim" = mkLogoPath "neovim.png";
    "helix" = mkLogoPath "helix.png";
    "kitty" = if pkgs.kitty ? meta.icon then pkgs.kitty.meta.icon else mkLogoPath "kitty.png";
    "zen" = mkLogoPath "zen-browser.png";
    "brave" = mkLogoPath "brave.png";
    "default_web_bookmark" = mkLogoPath "generic_link.png";

    # Fallbacks
    "default_app" = mkLogoPath "generic_app.png";
    "default_profile" = mkLogoPath "generic_profile.png";
  };

  defaultLogoKey = {
    application = "default_app";
    webBookmark = "default_web_bookmark";
    profile = "default_profile";
  };

  genericStrings = {
    prefix = {
      app = "App";
      webApp = "Web App";
      launcher = "Launcher";
    };
    suffix = {
      textEditor = "Text Editor";
      imageViewer = "Image Viewer";
      webBrowser = "Web Browser";
      profile = "Profile";
      mode = "Mode";
      bookmark = "Bookmark";
    };
    profileTypes = {
      personalProfile = "Personal";
      mediaProfile = "Media";
      workProfile = "Work";
      ukProfile = "UK";
      academicProfile = "Academic";
      bsogoodProfile = "Bsogood";
      phantomProfile = "Phantom";
      genaiDevProfile = "GenAI Dev";
      customPrivateProfile = "Private Custom";
      incognitoMode = "Incognito Mode";
      devProfile = "Development";
      mainZenProfile = "Main Zen";
      default = "General";
    };
    name = {
      # Deprecated if fully dynamic, but kept for reference or specific overrides
      appEditor = "${genericStrings.prefix.app} - ${genericStrings.suffix.textEditor}";
      appProfile = "${genericStrings.prefix.launcher} - ${genericStrings.suffix.profile}";
    };
  };

  defaultCategories = {
    app = [ "Application" ];
    textEditor = [ "Utility" "TextEditor" "Development" ];
    terminalEmulator = [ "Utility" "System" "TerminalEmulator" ];
    webBrowserProfile = [ "Network" "WebBrowser" "Profile" ];
    webBookmark = [ "Network" "WebBrowser" ];
  };

  browserExecutables = {
    firefox = {
      pkg = pkgs.firefox;
      bin = "firefox";
      newWindowArg = "--new-window";
      prettyName = "Firefox";
    };
    librewolf = {
      pkg = pkgs.librewolf;
      bin = "librewolf";
      newWindowArg = "--new-window";
      prettyName = "Librewolf";
    };
    zen = {
      pkg = pkgs.zen-browser or pkgs.firefox;
      bin = if pkgs ? zen-browser then "zen-browser" else "firefox";
      newWindowArg = "--new-window";
      prettyName = "Zen Browser";
    };
    brave = {
      pkg = pkgs.brave;
      bin = "brave";
      newWindowArg = "--new-window";
      prettyName = "Brave";
    };
    chromium = {
      pkg = pkgs.chromium;
      bin = "chromium";
      newWindowArg = "--new-window";
      prettyName = "Chromium";
    };
  };

  defaultTerminalCommand = config.home.sessionVariables.TERMINAL or "${pkgs.kitty}/bin/kitty";
}

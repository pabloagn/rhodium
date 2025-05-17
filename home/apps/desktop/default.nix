# home/apps/desktop/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.desktop;

  # Import logo definitions
  logos = import ../../../lib/logos.nix {
    inherit lib config;
  };

  # Environment Variables
  terminal = config.home.sessionVariables.TERMINAL or "kitty";
  editor = config.home.sessionVariables.EDITOR or "nano";
  visual = config.home.sessionVariables.VISUAL or "code";

  # Generic Name Types
  generic = {
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

  firefoxNewWindow = "-new-window";
in
{
  options.rhodium.apps.desktop = {
    enable = mkEnableOption "Rhodium's desktop applications";
  };

  # TODO: Eventually we will define a centralized list for all URLs and profiles (e.g., bookmarks)
  config = mkIf cfg.enable {
    home.packages = with pkgs; [

      # Editors
      (makeDesktopItem {
        name = "helix-instance";
        desktopName = "Helix";
        genericName = "${generic.name.appEditor}";
        exec = "${terminal} --directory ${config.home.homeDirectory} hx %F";
        icon = logos.helix;
        comment = "Edit text files in a terminal using Helix, detached from any terminal instance.";
        categories = [ "Utility" "TextEditor" ];
        terminal = false;
        type = "Application";
      })

      # NOTE: There's an actual hyprland shortcut for this, since there is this undeletable wrapper that confuses me on Rofi.
      (makeDesktopItem {
        name = "nvim-instance";
        desktopName = "Neovim";
        genericName = "${generic.name.appEditor}";
        # exec = "kitty nvim %F";
        exec = "${config.home.sessionVariables.TERMINAL} --directory /home/pabloagn nvim %F";
        icon = logos.neovim;
        comment = "Edit text files in a terminal using NeoVim, detached from any terminal instance.";
        categories = [ "Utility" "TextEditor" ];
        terminal = false;
        type = "Application";
      })

      # ---------------------------------------------------------
      # Image Viewers
      # ---------------------------------------------------------
      # Feh Image Viewer
      (makeDesktopItem {
        name = "feh-image-viewer";
        desktopName = "Feh Image Viewer";
        genericName = "${generic.name.appImageViewer}";
        exec = "${pkgs.feh}/bin/feh -Z --scale-down --auto-zoom --image-bg black %f";
        icon = logos.feh;
        comment = "View images with feh in full-screen mode with black background";
        categories = [ "Graphics" "Viewer" ];
        mimeTypes = [
          "image/bmp"
          "image/gif"
          "image/jpeg"
          "image/jpg"
          "image/pjpeg"
          "image/png"
          "image/tiff"
          "image/webp"
          "image/x-bmp"
          "image/x-pcx"
          "image/x-png"
          "image/x-portable-anymap"
          "image/x-portable-bitmap"
          "image/x-portable-graymap"
          "image/x-portable-pixmap"
          "image/x-tga"
          "image/x-xbitmap"
          "image/svg+xml"
        ];
      })

      # ---------------------------------------------------------
      # Firefox Profiles
      # ---------------------------------------------------------

      # Firefox Profile - Personal
      (makeDesktopItem {
        name = "firefox-personal";
        desktopName = "Firefox Personal";
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "Profile";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
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
        genericName = "${generic.name.appProfile}";
        exec = "${pkgs.firefox}/bin/firefox -P Private ${firefoxNewWindow} %u";
        icon = logos.firefox_private;
        comment = "Launch Firefox with custom Private profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Mode- Incognito
      (makeDesktopItem {
        name = "firefox-incognito";
        desktopName = "Firefox Incognito";
        genericName = "${generic.name.appMode}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} %u --private-window";
        icon = logos.firefox;
        comment = "Launch Firefox with Incognito mode.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # ---------------------------------------------------------
      # Firefox Websites
      # ---------------------------------------------------------

      # Firefox Media
      # ---------------------------------------------------------

      # Firefox Media - YouTube
      (makeDesktopItem {
        name = "firefox-media-youtube";
        desktopName = "YouTube";
        genericName = "${generic.name.webAppMedia}";
        exec = "${pkgs.firefox}/bin/firefox -P Media ${firefoxNewWindow} https://youtube.com";
        icon = logos.youtube;
        comment = "Launch YouTube Web App under the Firefox Media Profile. Furthermore, it will by default be opened in the YouTube container.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal
      # ---------------------------------------------------------

      # Firefox Personal - Linear
      (makeDesktopItem {
        name = "firefox-personal-linear";
        desktopName = "Linear";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://linear.app/";
        icon = logos.linear;
        comment = "Launch Linear Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Akiflow
      (makeDesktopItem {
        name = "firefox-personal-akiflow";
        desktopName = "Akiflow";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://web.akiflow.com";
        icon = logos.akiflow;
        comment = "Launch Akiflow Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - ProtonDrive
      (makeDesktopItem {
        name = "firefox-personal-protondrive";
        desktopName = "ProtonDrive";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://drive.proton.me/";
        icon = logos.protonDrive;
        comment = "Launch ProtonDrive Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - ProtonMail
      (makeDesktopItem {
        name = "firefox-personal-protonmail";
        desktopName = "ProtonMail";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://mail.proton.me/";
        icon = logos.protonMail;
        comment = "Launch ProtonMail Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Reddit
      (makeDesktopItem {
        name = "firefox-personal-reddit";
        desktopName = "Reddit";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://reddit.com";
        icon = logos.reddit;
        comment = "Launch Reddit Web App under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Goodreads
      (makeDesktopItem {
        name = "firefox-personal-goodreads";
        desktopName = "Goodreads";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://goodreads.com";
        icon = logos.goodreads;
        comment = "Launch Goodreads Web App under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Google Search
      # Note the flags we need to include in order for Google to be a trully add-free experience
      # There are sometimes certain URL flafgs we can use. We'll include them here ;).
      (makeDesktopItem {
        name = "firefox-personal-google-search";
        desktopName = "Google Search";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://www.google.com/search";
        icon = logos.google;
        comment = "Launch Google Search Engine under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Google Advanced Search
      # Note the flags we need to include in order for Google to be a trully add-free experience
      # There are sometimes certain URL flafgs we can use. We'll include them here ;).
      (makeDesktopItem {
        name = "firefox-personal-google-advanced-search";
        desktopName = "Google Advanced Search";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://www.google.com/advanced_search";
        icon = logos.google;
        comment = "Launch Google Advanced Search Engine under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Google Advanced Image Search
      (makeDesktopItem {
        name = "firefox-personal-google-images";
        desktopName = "Google Images";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://www.google.com/advanced_image_search";
        icon = logos.google;
        comment = "Launch Google Advanced Image Search Engine under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - GitHub
      (makeDesktopItem {
        name = "firefox-personal-github";
        desktopName = "GitHub";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://github.com/pabloagn";
        icon = logos.github;
        comment = "Launch GitHub Web App on personal repositories list under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - LinkedIn
      (makeDesktopItem {
        name = "firefox-personal-linkedin";
        desktopName = "LinkedIn";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://www.linkedin.com";
        icon = logos.linkedin;
        comment = "Launch LinkedIn Web App under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - NixOS Packages
      (makeDesktopItem {
        name = "firefox-personal-nixos-packages";
        desktopName = "NixOS Packages";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://search.nixos.org/packages";
        icon = logos.nixos;
        comment = "Launch NixOS Packages search under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - MyNixOS
      (makeDesktopItem {
        name = "firefox-personal-mynixos";
        desktopName = "MyNixOS";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://mynixos.com";
        icon = logos.nixos;
        comment = "Launch MyNixOS under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - NixOS Home Manager Options
      (makeDesktopItem {
        name = "firefox-personal-nixos-home-manager";
        desktopName = "NixOS Home Manager Options";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://nix-community.github.io/home-manager/options.html";
        icon = logos.nixos;
        comment = "Launch NixOS Home Manager Options under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Pastebin
      (makeDesktopItem {
        name = "firefox-personal-pastebin";
        desktopName = "Pastebin";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://pastebin.com";
        icon = logos.pastebin;
        comment = "Launch Pastebin under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })
      # Firefox Personal - Unsplash
      (makeDesktopItem {
        name = "firefox-personal-unsplash";
        desktopName = "Unsplash";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://unsplash.com";
        icon = logos.unsplash;
        comment = "Launch Unsplash under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Amazon Mexico
      (makeDesktopItem {
        name = "firefox-personal-amazon-mexico";
        desktopName = "Amazon Mexico";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://amazon.com.mx";
        icon = logos.amazon;
        comment = "Launch Amazon Mexico under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Personal - Standard Notes
      (makeDesktopItem {
        name = "firefox-personal-standard-notes";
        desktopName = "Standard Notes";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://app.standardnotes.com/";
        icon = logos.standardNotes;
        comment = "Launch Standard Notes under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })


      # Firefox GenAI
      # ---------------------------------------------------------

      # Firefox AI - ClaudeAI
      (makeDesktopItem {
        name = "firefox-genai-claude";
        desktopName = "ClaudeAI";
        genericName = "${generic.name.webAppGenai}";
        exec = "${pkgs.firefox}/bin/firefox -P GenAI ${firefoxNewWindow} https://claude.ai";
        icon = logos.claude;
        comment = "Launch ClaudeAI under the Firefox GenAI Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox AI - GeminiAI
      (makeDesktopItem {
        name = "firefox-genai-gemini";
        desktopName = "GeminiAI";
        genericName = "${generic.name.webAppGenai}";
        exec = "${pkgs.firefox}/bin/firefox -P GenAI ${firefoxNewWindow} https://aistudio.google.com/";
        icon = logos.googleGemini;
        comment = "Launch GeminiAI under the Firefox GenAI Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox GenAI - ChatGPT
      (makeDesktopItem {
        name = "firefox-genai-chatgpt";
        desktopName = "ChatGPT";
        genericName = "${generic.name.webAppGenai}";
        exec = "${pkgs.firefox}/bin/firefox -P GenAI ${firefoxNewWindow} https://chatgpt.com";
        icon = logos.chatgpt;
        comment = "Launch ChatGPT under the Firefox GenAI Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox GenAI - PerplexityAI
      (makeDesktopItem {
        name = "firefox-genai-perplexity";
        desktopName = "PerplexityAI";
        genericName = "${generic.name.webAppGenai}";
        exec = "${pkgs.firefox}/bin/firefox -P GenAI ${firefoxNewWindow} https://www.perplexity.ai/";
        icon = logos.perplexity;
        comment = "Launch PerplexityAI under the Firefox GenAI Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom
      # ---------------------------------------------------------

      # Firefox United Kingdom - Google Maps
      (makeDesktopItem {
        name = "firefox-uk-google-maps";
        desktopName = "Google Maps";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://maps.google.com";
        icon = logos.google;
        comment = "Launch Google Maps under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - AirBnB
      (makeDesktopItem {
        name = "firefox-uk-airbnb";
        desktopName = "AirBnB";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://airbnb.co.uk";
        icon = logos.airbnb;
        comment = "Launch AirBnB under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - Amazon UK
      (makeDesktopItem {
        name = "firefox-uk-amazon";
        desktopName = "Amazon UK";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://amazon.co.uk";
        icon = logos.amazon;
        comment = "Launch Amazon UK under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - PayPal UK
      (makeDesktopItem {
        name = "firefox-uk-paypal-uk";
        desktopName = "PayPal UK";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://www.paypal.com/uk";
        icon = logos.paypal;
        comment = "Launch PayPal UK under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - IKEA
      (makeDesktopItem {
        name = "firefox-uk-ikea-uk";
        desktopName = "IKEA United Kingdom";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://www.ikea.com/gb/en/";
        icon = logos.ikea;
        comment = "Launch IKEA UK under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - Google Maps
      (makeDesktopItem {
        name = "firefox-uk-google-maps";
        desktopName = "Google Maps";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://maps.google.com";
        icon = logos.google;
        comment = "Launch Google Maps under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - Tesco
      (makeDesktopItem {
        name = "firefox-uk-tesco";
        desktopName = "Tesco";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://www.tesco.com/groceries/";
        icon = logos.tesco;
        comment = "Launch Tesco Groceries under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - Sainsbury's
      (makeDesktopItem {
        name = "firefox-uk-sainsburys";
        desktopName = "Sainsbury's";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://www.sainsburys.co.uk/gol-ui/groceries";
        icon = logos.sainsburys;
        comment = "Launch Sainsbury's Groceries under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox United Kingdom - Boots
      (makeDesktopItem {
        name = "firefox-uk-boots";
        desktopName = "Boots";
        genericName = "${generic.name.webAppUk}";
        exec = "${pkgs.firefox}/bin/firefox -P UnitedKingdom ${firefoxNewWindow} https://www.boots.com/";
        icon = logos.boots;
        comment = "Launch Boots under the Firefox United Kingdom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Solenoid Labs
      # ---------------------------------------------------------

      # Firefox Solenoid Labs Pablo - Upwork
      (makeDesktopItem {
        name = "firefox-solenoid-labs-pablo-upwork";
        desktopName = "Upwork";
        genericName = "${generic.name.webAppSolenoidLabs}";
        exec = "${pkgs.firefox}/bin/firefox -P SolenoidLabsPablo ${firefoxNewWindow} https://upwork.com";
        icon = logos.upwork;
        comment = "Launch Upwork under the Firefox Solenoid Labs Pablo Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Solenoid Labs Pablo - Figma
      (makeDesktopItem {
        name = "firefox-solenoid-labs-pablo-figma";
        desktopName = "Figma";
        genericName = "${generic.name.webAppSolenoidLabs}";
        exec = "${pkgs.firefox}/bin/firefox -P SolenoidLabsPablo ${firefoxNewWindow} https://figma.com";
        icon = logos.figma;
        comment = "Launch Figma under the Firefox Solenoid Labs Pablo Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Solenoid Labs Pablo - Google Drive
      (makeDesktopItem {
        name = "firefox-solenoid-labs-pablo-googledrive";
        desktopName = "Google Drive";
        genericName = "${generic.name.webAppSolenoidLabs}";
        exec = "${pkgs.firefox}/bin/firefox -P SolenoidLabsPablo ${firefoxNewWindow} https://drive.google.com";
        icon = logos.googleDrive;
        comment = "Launch Google Drive under the Firefox Solenoid Labs Pablo Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Solenoid Labs - GitHub
      (makeDesktopItem {
        name = "firefox-solenoid-labs-pablo-github";
        desktopName = "GitHub Solenoid Labs";
        genericName = "${generic.name.webAppSolenoidLabs}";
        exec = "${pkgs.firefox}/bin/firefox -P SolenoidLabsPablo ${firefoxNewWindow} https://github.com/orgs/Solenoid-Labs/repositories";
        icon = logos.github;
        comment = "Launch GitHub Web App on Solenoid Labs repositories list under the Firefox Solenoid Labs Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Firefox Academic
      # ---------------------------------------------------------

      # Firefox Academic - Blackboard
      (makeDesktopItem {
        name = "firefox-academic-blackboard";
        desktopName = "Blackboard";
        genericName = "${generic.name.webAppAcademic}";
        exec = "${pkgs.firefox}/bin/firefox -P Academic ${firefoxNewWindow} https://www.ole.bris.ac.uk/ultra/institution-page";
        icon = logos.blackboard;
        comment = "Launch Blackboard home page under the Firefox Academic Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Key GitHub Repositories
      # ---------------------------------------------------------

      # Phantom
      (makeDesktopItem {
        name = "firefox-phantom-github";
        desktopName = "GitHub Phantom";
        genericName = "${generic.name.webAppPhantom}";
        exec = "${pkgs.firefox}/bin/firefox -P TheHumanPalace ${firefoxNewWindow} https://github.com/pabloagn/phantom";
        icon = logos.github;
        comment = "Launch GitHub Web App on Phantom repository under the Firefox Phantom Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Rhodium
      (makeDesktopItem {
        name = "firefox-rhodium-github";
        desktopName = "GitHub Rhodium";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://github.com/pabloagn/rhodium";
        icon = logos.github;
        comment = "Launch GitHub Web App on Rhodium repository under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })

      # Scalpel
      (makeDesktopItem {
        name = "firefox-scalpel-github";
        desktopName = "GitHub Scalpel";
        genericName = "${generic.name.webAppPersonal}";
        exec = "${pkgs.firefox}/bin/firefox -P Personal ${firefoxNewWindow} https://github.com/pabloagn/scalpel";
        icon = logos.github;
        comment = "Launch GitHub Web App on Scalpel repository under the Firefox Personal Profile.";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [ "text/html" "text/xml" ];
      })
    ];
  };
}

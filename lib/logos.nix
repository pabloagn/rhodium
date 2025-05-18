# lib/logos.nix

{ lib, config ? null }:

let
  # Import paths to get the logos directory
  pathsLib = import ./modules/paths.nix {
    inherit lib config;
  };

  logosExtension = "png";

  # Base path to logos
  logosPath = pathsLib.rhodium.assets.logos;

  # Define logo names with their paths
  logos = {

    # Browsers
    firefox = {
      general = "${logosPath}/firefox_general.${logosExtension}";
      private = "${logosPath}/firefox_private.${logosExtension}";
      media = "${logosPath}/firefox_media.${logosExtension}";
    };
    zenBrowser = "${logosPath}/zen_browser.${logosExtension}"; # TODO: Get logo
    torBrowser = "${logosPath}/tor_browser.${logosExtension}";

    # Editors
    neovim = "${logosPath}/neovim.${logosExtension}";
    helix = "${logosPath}/helix.${logosExtension}"; # TODO: Get logo

    # AI
    claude = "${logosPath}/claude.${logosExtension}";
    chatgpt = "${logosPath}/chatgpt.${logosExtension}";
    perplexity = "${logosPath}/perplexityai.${logosExtension}";
    googleGemini = "${logosPath}/googlegemini.${logosExtension}";

    # Productivity & Design
    figma = "${logosPath}/figma.${logosExtension}";
    linear = "${logosPath}/linear.${logosExtension}";
    akiflow = "${logosPath}/akiflow.${logosExtension}";
    notion = "${logosPath}/notion.${logosExtension}";

    # Services
    github = "${logosPath}/github.${logosExtension}";
    google = "${logosPath}/google.${logosExtension}";
    googleDrive = "${logosPath}/googledrive.${logosExtension}";
    protonMail = "${logosPath}/protonmail.${logosExtension}";
    protonDrive = "${logosPath}/protondrive.${logosExtension}";
    pastebin = "${logosPath}/pastebin.${logosExtension}";
    unsplash = "${logosPath}/unsplash.${logosExtension}";

    # Shopping & Retail
    amazon = "${logosPath}/amazon.${logosExtension}";
    ikea = "${logosPath}/ikea.${logosExtension}";
    boots = "${logosPath}/boots.${logosExtension}";
    tesco = "${logosPath}/tesco.${logosExtension}";
    sainsburys = "${logosPath}/sainsburys.${logosExtension}";
    paypal = "${logosPath}/paypal.${logosExtension}";

    # Social
    reddit = "${logosPath}/reddit.${logosExtension}";
    linkedin = "${logosPath}/linkedin.${logosExtension}";
    youtube = "${logosPath}/youtube.${logosExtension}";

    # Work & Education
    upwork = "${logosPath}/upwork.${logosExtension}";
    blackboard = "${logosPath}/blackboard.${logosExtension}";

    # Note-taking
    standardNotes = "${logosPath}/standard_notes.${logosExtension}";
    goodreads = "${logosPath}/goodreads.${logosExtension}";

    # Other
    nixos = "${logosPath}/nixos.${logosExtension}";
    airbnb = "${logosPath}/airbnb.${logosExtension}";
  };

in
logos

# lib/logos.nix

{ lib, config ? null }:

let
  # Import paths to get the logos directory
  pathsLib = import ./modules/paths.nix {
    inherit lib config;
  };

  # Base path to logos
  logosPath = pathsLib.rhodium.assets.logos;

  # Define logo names with their paths
  logos = {

    # Browsers
    firefox = {
      general = "${logosPath}/firefox_general.png";
      private = "${logosPath}/firefox_private.png";
      media = "${logosPath}/firefox_media.png";
    };
    zenBrowser = "${logosPath}/zen_browser.png"; # TODO: Get logo
    torBrowser = "${logosPath}/tor_browser.png";

    # Editors
    neovim = "${logosPath}/neovim.png";
    helix = "${logosPath}/helix.png"; # TODO: Get logo

    # AI
    claude = "${logosPath}/claude.png";
    chatgpt = "${logosPath}/chatgpt.png";
    perplexity = "${logosPath}/perplexityai.png";
    googleGemini = "${logosPath}/googlegemini.png";

    # Productivity & Design
    figma = "${logosPath}/figma.png";
    linear = "${logosPath}/linear.png";
    akiflow = "${logosPath}/akiflow.png";
    notion = "${logosPath}/notion.png";

    # Services
    github = "${logosPath}/github.png";
    google = "${logosPath}/google.png";
    googleDrive = "${logosPath}/googledrive.png";
    protonMail = "${logosPath}/protonmail.png";
    protonDrive = "${logosPath}/protondrive.png";
    pastebin = "${logosPath}/pastebin.png";
    unsplash = "${logosPath}/unsplash.png";

    # Shopping & Retail
    amazon = "${logosPath}/amazon.png";
    ikea = "${logosPath}/ikea.png";
    boots = "${logosPath}/boots.png";
    tesco = "${logosPath}/tesco.png";
    sainsburys = "${logosPath}/sainsburys.png";
    paypal = "${logosPath}/paypal.png";

    # Social
    reddit = "${logosPath}/reddit.png";
    linkedin = "${logosPath}/linkedin.png";
    youtube = "${logosPath}/youtube.png";

    # Work & Education
    upwork = "${logosPath}/upwork.png";
    blackboard = "${logosPath}/blackboard.png";

    # Note-taking
    standardNotes = "${logosPath}/standard_notes.png";
    goodreads = "${logosPath}/goodreads.png";

    # Other
    nixos = "${logosPath}/nixos.png";
    airbnb = "${logosPath}/airbnb.png";
  };

in
logos

let
  categories = {
    utils = "utils";
    finance = "finance";
    entertainment = "entertainment";
    productivity = "productivity";
    shopping = "shopping";
    social = "social";
    reference = "reference";
    news = "news";
    servers = "servers";
    design = "design";
    travel = "travel";
    torrenting = "torrenting";
    config = "config";
    repositories = "repositories";
    youtubelists = "youtube lists";
  };
in
{
  academic = {
    blackboard = {
      profile = "academic";
      url = "https://www.ole.bris.ac.uk/ultra/institution-page";
      description = "Blackboard";
      categories = [ categories.productivity ];
    };
    overleaf = {
      profile = "academic";
      url = "https://www.overleaf.com";
      description = "Overleaf";
      categories = [ categories.productivity ];
    };
  };

  genai = {
    chatgpt = {
      profile = "genai";
      url = "https://chatgpt.com";
      description = "ChatGPT";
      categories = [ categories.productivity ];
    };
    claude = {
      profile = "genai";
      url = "https://claude.ai";
      description = "ClaudeAI";
      categories = [ categories.productivity ];
    };
    gemini = {
      profile = "genai";
      url = "https://aistudio.google.com/";
      description = "GeminiAI";
      categories = [ categories.productivity ];
    };
    perplexity = {
      profile = "genai";
      url = "https://www.perplexity.ai/";
      description = "PerplexityAI";
      categories = [ categories.productivity ];
    };
  };

  media = {
    darknetdiaries = {
      profile = "media";
      url = "https://darknetdiaries.com/";
      description = "Darknet Diaries";
      categories = [ categories.entertainment ];
    };
    highclouds = {
      profile = "media";
      url = "https://highclouds.org/";
      description = "HighClouds - A Music Blog";
      categories = [ categories.entertainment ];
    };
    torrenting-1337xto = {
      profile = "media";
      url = "https://1337x.to/";
      description = "1337x.to";
      categories = [ categories.entertainment categories.torrenting ];
    };
    torrenting-thepiratebay = {
      profile = "media";
      url = "https://thepiratebay.org/index.html";
      description = "The Pirate Bay";
      categories = [ categories.entertainment categories.torrenting ];
    };
    video-downloader = {
      profile = "media";
      url = "https://www.savethevideo.com/home";
      description = "Video Downloader";
      categories = [ categories.utils ];
    };
    youtube = {
      profile = "media";
      url = "https://www.youtube.com/";
      description = "YouTube";
      categories = [ categories.entertainment ];
    };
    youtube-allianz-tutorial = {
      profile = "media";
      url = "https://www.youtube.com/watch?v=1wJej9RTHwg";
      description = "YouTube Allianz Tutorial";
      categories = [ categories.finance ];
    };
    youtube-watchlater = {
      profile = "media";
      url = "https://www.youtube.com/playlist?list=WL";
      description = "YouTube Watch Later";
      categories = [ categories.youtubelists ];
    };
    youtube-favourites = {
      profile = "media";
      url = "https://www.youtube.com/playlist?list=PLtKw21JMGIZT5E1K7VD3xPP_sSVrmjJOz";
      description = "YouTube Favourites";
      categories = [ categories.youtubelists ];
    };
    youtube-hilarious = {
      profile = "media";
      url = "https://www.youtube.com/playlist?list=PLtKw21JMGIZQntylwooKidO54HZuaFtAx";
      description = "YouTube Hilarious";
      categories = [ categories.youtubelists ];
    };
    youtube-music = {
      profile = "media";
      url = "https://www.youtube.com/playlist?list=PLtKw21JMGIZSJS17DN65x0VIS7vM5nBki";
      description = "YouTube Music";
      categories = [ categories.youtubelists ];
    };
  };

  personal = {
    akiflow = {
      profile = "personal";
      url = "https://web.akiflow.com";
      description = "Akiflow";
      categories = [ categories.productivity ];
    };
    allianz = {
      profile = "personal";
      url = "https://clientes.allianz.com.mx/";
      description = "Allianz";
      categories = [ categories.finance ];
    };
    allianz-plus-pdf = {
      profile = "personal";
      url = "https://www.allianz.com.mx/content/dam/onemarketing/iberolatam/allianz-mx/ahorro---plus/documentos---plus/Folleto%20-%20PLUS.pdf";
      description = "Allianz Plus PDF";
      categories = [ categories.finance categories.reference ];
    };
    amazon-mexico = {
      profile = "personal";
      url = "https://amazon.com.mx";
      description = "Amazon Mexico";
      categories = [ categories.shopping ];
    };
    american-express = {
      profile = "personal";
      url = "https://www.americanexpress.com/es-mx/account/login";
      description = "American Express";
      categories = [ categories.finance ];
    };
    asciiart = {
      profile = "personal";
      url = "https://www.asciiart.eu/";
      description = "ASCII Art";
      categories = [ categories.design categories.reference ];
    };
    asciiart-imagetoascii = {
      profile = "personal";
      url = "https://www.asciiart.eu/image-to-ascii";
      description = "ASCII Art - Image to ASCII";
      categories = [ categories.design categories.utils ];
    };
    cloudping = {
      profile = "personal";
      url = "https://www.cloudping.info/";
      description = "Cloudping";
      categories = [ categories.utils categories.reference ];
    };
    common-mimetypes = {
      profile = "personal";
      url = "https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types/Common_types";
      description = "Common MIME Types";
      categories = [ categories.reference ];
    };
    downloads = {
      profile = "personal";
      url = "about:downloads";
      description = "Downloads";
      categories = [ categories.utils ];
    };
    emojipedia = {
      profile = "personal";
      url = "https://emojipedia.org/";
      description = "Emojipedia";
      categories = [ categories.reference ];
    };
    firefox-addons = {
      profile = "personal";
      url = "about:addons";
      description = "Firefox Addons";
      categories = [ categories.config ];
    };
    firefox-extensions = {
      profile = "personal";
      url = "https://addons.mozilla.org/en-US/firefox/extensions/";
      description = "Firefox Extensions";
      categories = [ categories.utils ];
    };
    firefox-profiles = {
      profile = "personal";
      url = "about:profiles";
      description = "Firefox Profiles";
      categories = [ categories.utils ];
    };
    firefox-settings = {
      profile = "personal";
      url = "about:settings";
      description = "Firefox Settings";
      categories = [ categories.utils ];
    };
    firefox-themes = {
      profile = "personal";
      url = "https://addons.mozilla.org/en-US/firefox/themes/";
      description = "Firefox Themes";
      categories = [ categories.design ];
    };
    github = {
      profile = "personal";
      url = "https://github.com/pabloagn?tab=repositories";
      description = "GitHub Repos";
      categories = [ categories.productivity ];
    };
    github-chiaroscuro = {
      profile = "personal";
      url = "https://github.com/pabloagn/chiaroscuro";
      description = "GitHub Chiaroscuro";
      categories = [ categories.productivity categories.repositories ];
    };
    github-phantom = {
      profile = "personal";
      url = "https://github.com/pabloagn/phantom";
      description = "GitHub Phantom";
      categories = [ categories.productivity categories.repositories ];
    };
    github-rhodium = {
      profile = "personal";
      url = "https://github.com/pabloagn/rhodium";
      description = "GitHub Rhodium";
      categories = [ categories.productivity categories.repositories ];
    };
    gnome-style-schemes = {
      profile = "personal";
      url = "https://wiki.gnome.org/Projects/GtkSourceView/StyleSchemes";
      description = "GNOME Style Schemes";
      categories = [ categories.reference categories.design ];
    };
    goodreads = {
      profile = "personal";
      url = "https://goodreads.com";
      description = "Goodreads";
      categories = [ categories.entertainment categories.social ];
    };
    google-advanced-search = {
      profile = "personal";
      url = "https://www.google.com/advanced_search";
      description = "Google Advanced Search";
      categories = [ categories.utils ];
    };
    google-images = {
      profile = "personal";
      url = "https://www.google.com/advanced_image_search";
      description = "Google Images";
      categories = [ categories.utils ];
    };
    google-search = {
      profile = "personal";
      url = "https://www.google.com/search";
      description = "Google Search";
      categories = [ categories.utils ];
    };
    incognito = {
      profile = "personal";
      url = "about:privatebrowsing";
      description = "Firefox Incognito";
      categories = [ categories.utils ];
    };
    inoreader = {
      profile = "personal";
      url = "https://www.inoreader.com/";
      description = "Inoreader";
      categories = [ categories.news categories.productivity ];
    };
    letterboxd = {
      profile = "personal";
      url = "https://letterboxd.com/jk_huysmans/films/diary/";
      description = "Letterboxd - Diary";
      categories = [ categories.entertainment categories.social ];
    };
    linear = {
      profile = "personal";
      url = "https://linear.app/sanctum-black";
      description = "Linear";
      categories = [ categories.productivity ];
    };
    linear-rhodium = {
      profile = "personal";
      url = "https://linear.app/sanctum-black/project/0607-sys-prj-rhodium-3fc0956ba956/issues";
      description = "Linear Rhodium";
      categories = [ categories.productivity ];
    };
    linkedin = {
      profile = "personal";
      url = "https://www.linkedin.com";
      description = "LinkedIn";
      categories = [ categories.social categories.productivity ];
    };
    markdown-to-excel = {
      profile = "personal";
      url = "https://tableconvert.com/markdown-to-excel";
      description = "Markdown to Excel";
      categories = [ categories.utils ];
    };
    medium = {
      profile = "personal";
      url = "https://medium.com";
      description = "Medium";
      categories = [ categories.news categories.reference ];
    };
    mercadolibre = {
      profile = "personal";
      url = "https://www.mercadolibre.com.mx/";
      description = "MercadoLibre";
      categories = [ categories.shopping ];
    };
    mynixos = {
      profile = "personal";
      url = "https://mynixos.com";
      description = "MyNixOS";
      categories = [ categories.reference ];
    };
    nerdfonts = {
      profile = "personal";
      url = "https://www.nerdfonts.com/cheat-sheet";
      description = "NerdFonts Cheat Sheet";
      categories = [ categories.reference categories.design ];
    };
    nix-operators = {
      profile = "personal";
      url = "https://nix.dev/manual/nix/2.25/language/operators.html";
      description = "Nix Operators";
      categories = [ categories.reference ];
    };
    nix-pills = {
      profile = "personal";
      url = "https://nixos.org/guides/nix-pills/";
      description = "Nix Pills";
      categories = [ categories.reference ];
    };
    nixos-environment-variables = {
      profile = "personal";
      url = "https://nixos.wiki/wiki/Environment_variables";
      description = "NixOS Environment Variables";
      categories = [ categories.reference ];
    };
    nixos-home-manager-manual = {
      profile = "personal";
      url = "https://nix-community.github.io/home-manager/";
      description = "NixOS Home Manager Manual";
      categories = [ categories.reference ];
    };
    nixos-home-manager-options = {
      profile = "personal";
      url = "https://home-manager-options.extranix.com/";
      description = "NixOS Home Manager Options";
      categories = [ categories.reference ];
    };
    nixos-options = {
      profile = "personal";
      url = "https://search.nixos.org/options";
      description = "NixOS Options";
      categories = [ categories.reference ];
    };
    nixos-packages = {
      profile = "personal";
      url = "https://search.nixos.org/packages";
      description = "NixOS Packages";
      categories = [ categories.reference ];
    };
    omnivore = {
      profile = "personal";
      url = "https://omnivore.app/home";
      description = "Omnivore";
      categories = [ categories.news ];
    };
    p5js = {
      profile = "personal";
      url = "https://editor.p5js.org/";
      description = "P5.js Web Editor";
      categories = [ categories.utils ];
    };
    pastebin = {
      profile = "personal";
      url = "https://pastebin.com";
      description = "Pastebin";
      categories = [ categories.utils ];
    };
    pinterest = {
      profile = "personal";
      url = "https://pinterest.com";
      description = "Pinterest";
      categories = [ categories.design categories.social ];
    };
    plainapp-fiio = {
      profile = "personal";
      url = "http://10.141.245.168:8080/";
      description = "PlainApp FiiO M11 Plus";
      categories = [ categories.servers categories.entertainment ];
    };
    plainapp-oppo = {
      profile = "personal";
      url = "https://10.141.245.132:8443/";
      description = "PlainApp Oppo";
      categories = [ categories.servers categories.entertainment ];
    };
    plex = {
      profile = "personal";
      url = "https://app.plex.tv/";
      description = "Plex";
      categories = [ categories.entertainment categories.servers ];
    };
    preferences = {
      profile = "personal";
      url = "about:preferences";
      description = "Preferences";
      categories = [ categories.utils ];
    };
    preferences-containers = {
      profile = "personal";
      url = "about:preferences#containers";
      description = "Preferences Containers";
      categories = [ categories.utils ];
    };
    preferences-privacy = {
      profile = "personal";
      url = "about:preferences#privacy";
      description = "Preferences Privacy";
      categories = [ categories.utils ];
    };
    protondashboard = {
      profile = "personal";
      url = "https://account.proton.me/u/0/mail/dashboard";
      description = "ProtonDashboard";
      categories = [ categories.productivity ];
    };
    protondrive = {
      profile = "personal";
      url = "https://drive.proton.me/";
      description = "ProtonDrive";
      categories = [ categories.productivity ];
    };
    protonmail = {
      profile = "personal";
      url = "https://mail.proton.me/";
      description = "ProtonMail";
      categories = [ categories.productivity ];
    };
    reddit = {
      profile = "personal";
      url = "https://reddit.com";
      description = "Reddit";
      categories = [ categories.social categories.entertainment ];
    };
    server-LME-QNAP-6S4R = {
      profile = "personal";
      url = "http://192.168.1.129:8080/cgi-bin/";
      description = "LME-QNAP-6S4R";
      categories = [ categories.servers ];
    };
    server-alexandria = {
      profile = "personal";
      url = "http://google.com";
      description = "Alexandria";
      categories = [ categories.servers ];
    };
    simpleicons = {
      profile = "personal";
      url = "https://simpleicons.org/";
      description = "SimpleIcons";
      categories = [ categories.productivity ];
    };
    standard-notes = {
      profile = "personal";
      url = "https://app.standardnotes.com/";
      description = "Standard Notes";
      categories = [ categories.productivity ];
    };
    terminal-sexy = {
      profile = "personal";
      url = "https://terminal.sexy/";
      description = "Terminal.Sexy";
      categories = [ categories.design categories.utils ];
    };
    tvtime = {
      profile = "personal";
      url = "https://app.tvtime.com/welcome";
      description = "TV Time";
      categories = [ categories.entertainment categories.social ];
    };
    unsplash = {
      profile = "personal";
      url = "https://unsplash.com";
      description = "Unsplash";
      categories = [ categories.design ];
    };
    whatsapp = {
      profile = "personal";
      url = "https://web.whatsapp.com/";
      description = "Whatsapp";
      categories = [ categories.productivity ];
    };
    yazi-docs = {
      profile = "personal";
      url = "https://yazi-rs.github.io/docs/installation";
      description = "Yazi Documentation";
      categories = [ categories.reference ];
    };
  };

  solenoidlabs = {
    figma = {
      profile = "solenoidlabs";
      url = "https://figma.com";
      description = "Figma";
      categories = [ categories.design categories.productivity ];
    };
    github = {
      profile = "solenoidlabs";
      url = "https://github.com/orgs/Solenoid-Labs/repositories";
      description = "GitHub Solenoid Labs";
      categories = [ categories.productivity ];
    };
    googledrive = {
      profile = "solenoidlabs";
      url = "https://drive.google.com";
      description = "Google Drive";
      categories = [ categories.productivity ];
    };
    upwork = {
      profile = "solenoidlabs";
      url = "https://upwork.com";
      description = "Upwork";
      categories = [ categories.productivity ];
    };
  };

  uk = {
    airbnb = {
      profile = "uk";
      url = "https://airbnb.co.uk";
      description = "AirBnB";
      categories = [ categories.travel ];
    };
    amazon = {
      profile = "uk";
      url = "https://amazon.co.uk";
      description = "Amazon UK";
      categories = [ categories.shopping ];
    };
    boots = {
      profile = "uk";
      url = "https://www.boots.com/";
      description = "Boots";
      categories = [ categories.shopping ];
    };
    google-maps = {
      profile = "uk";
      url = "https://maps.google.com";
      description = "Google Maps";
      categories = [ categories.utils ];
    };
    ikea-uk = {
      profile = "uk";
      url = "https://www.ikea.com/gb/en/";
      description = "IKEA United Kingdom";
      categories = [ categories.shopping ];
    };
    paypal-uk = {
      profile = "uk";
      url = "https://www.paypal.com/uk";
      description = "PayPal UK";
      categories = [ categories.finance ];
    };
    sainsburys = {
      profile = "uk";
      url = "https://www.sainsburys.co.uk/gol-ui/groceries";
      description = "Sainsbury's";
      categories = [ categories.shopping ];
    };
    tesco = {
      profile = "uk";
      url = "https://www.tesco.com/groceries/";
      description = "Tesco";
      categories = [ categories.shopping ];
    };
  };
}

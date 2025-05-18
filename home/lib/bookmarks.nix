# home/lib/bookmarks.nix

[
  # Media Profile
  # -----------------------------------
  {
    idName = "media-youtube";
    siteName = "YouTube";
    url = "https://youtube.com";
    profileName = "Media";
    profileCategoryKey = "media";
    logoName = "youtube";
    comment = "Launch YouTube Web App under the Firefox Media Profile. Furthermore, it will by default be opened in the YouTube container.";
  }
  # Personal Profile
  # -----------------------------------
  {
    idName = "personal-linear";
    siteName = "Linear";
    url = "https://linear.app/";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "linear";
    comment = "Launch Linear Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
  }
  {
    idName = "personal-akiflow";
    siteName = "Akiflow";
    url = "https://web.akiflow.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "akiflow";
    comment = "Launch Akiflow Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
  }
  {
    idName = "personal-protondrive";
    siteName = "ProtonDrive";
    url = "https://drive.proton.me/";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "protonDrive";
    comment = "Launch ProtonDrive Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
  }
  {
    idName = "personal-protonmail";
    siteName = "ProtonMail";
    url = "https://mail.proton.me/";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "protonMail";
    comment = "Launch ProtonMail Web App under the Firefox Personal Profile. Furthermore, it will by default be opened in the Productivity container.";
  }
  {
    idName = "personal-reddit";
    siteName = "Reddit";
    url = "https://reddit.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "reddit";
  }
  {
    idName = "personal-goodreads";
    siteName = "Goodreads";
    url = "https://goodreads.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "goodreads";
  }
  {
    idName = "personal-google-search";
    siteName = "Google Search";
    url = "https://www.google.com/search";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "google";
  }
  {
    idName = "personal-google-advanced-search";
    siteName = "Google Advanced Search";
    url = "https://www.google.com/advanced_search";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "google";
  }
  {
    idName = "personal-google-images";
    siteName = "Google Images";
    url = "https://www.google.com/advanced_image_search";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "google";
  }
  {
    idName = "personal-github";
    siteName = "GitHub (pabloagn)";
    url = "https://github.com/pabloagn";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "github";
  }
  {
    idName = "personal-linkedin";
    siteName = "LinkedIn";
    url = "https://www.linkedin.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "linkedin";
  }
  {
    idName = "personal-nixos-packages";
    siteName = "NixOS Packages";
    url = "https://search.nixos.org/packages";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "nixos";
  }
  {
    idName = "personal-mynixos";
    siteName = "MyNixOS";
    url = "https://mynixos.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "nixos";
  }
  {
    idName = "personal-nixos-home-manager";
    siteName = "NixOS Home Manager Options";
    url = "https://nix-community.github.io/home-manager/options.html";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "nixos";
  }
  {
    idName = "personal-pastebin";
    siteName = "Pastebin";
    url = "https://pastebin.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "pastebin";
  }
  {
    idName = "personal-unsplash";
    siteName = "Unsplash";
    url = "https://unsplash.com";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "unsplash";
  }
  {
    idName = "personal-amazon-mexico";
    siteName = "Amazon Mexico";
    url = "https://amazon.com.mx";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "amazon";
  }
  {
    idName = "personal-standard-notes";
    siteName = "Standard Notes";
    url = "https://app.standardnotes.com/";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "standardNotes";
  }

  # GenAI Profile
  # -----------------------------------
  {
    idName = "genai-claude";
    siteName = "ClaudeAI";
    url = "https://claude.ai";
    profileName = "GenAI";
    profileCategoryKey = "genai";
    logoName = "claude";
  }
  {
    idName = "genai-gemini";
    siteName = "GeminiAI";
    url = "https://aistudio.google.com/";
    profileName = "GenAI";
    profileCategoryKey = "genai";
    logoName = "googleGemini";
  }
  {
    idName = "genai-chatgpt";
    siteName = "ChatGPT";
    url = "https://chatgpt.com";
    profileName = "GenAI";
    profileCategoryKey = "genai";
    logoName = "chatgpt";
  }
  {
    idName = "genai-perplexity";
    siteName = "PerplexityAI";
    url = "https://www.perplexity.ai/";
    profileName = "GenAI";
    profileCategoryKey = "genai";
    logoName = "perplexity";
  }

  # United Kingdom Profile
  # -----------------------------------
  {
    idName = "uk-google-maps";
    siteName = "Google Maps (UK)";
    url = "https://maps.google.com";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "google";
  }
  {
    idName = "uk-airbnb";
    siteName = "AirBnB UK";
    url = "https://airbnb.co.uk";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "airbnb";
  }
  {
    idName = "uk-amazon";
    siteName = "Amazon UK";
    url = "https://amazon.co.uk";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "amazon";
  }
  {
    idName = "uk-paypal";
    siteName = "PayPal UK";
    url = "https://www.paypal.com/uk";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "paypal";
  }
  {
    idName = "uk-ikea";
    siteName = "IKEA UK";
    url = "https://www.ikea.com/gb/en/";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "ikea";
  }
  {
    idName = "uk-tesco";
    siteName = "Tesco Groceries";
    url = "https://www.tesco.com/groceries/";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "tesco";
  }
  {
    idName = "uk-sainsburys";
    siteName = "Sainsbury's Groceries";
    url = "https://www.sainsburys.co.uk/gol-ui/groceries";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "sainsburys";
  }
  {
    idName = "uk-boots";
    siteName = "Boots";
    url = "https://www.boots.com/";
    profileName = "UnitedKingdom";
    profileCategoryKey = "uk";
    logoName = "boots";
  }

  # Solenoid Labs Profile
  # -----------------------------------
  {
    idName = "solenoid-labs-upwork";
    siteName = "Upwork (Solenoid)";
    url = "https://upwork.com";
    profileName = "SolenoidLabsPablo";
    profileCategoryKey = "solenoidLabs";
    logoName = "upwork";
  }
  {
    idName = "solenoid-labs-figma";
    siteName = "Figma (Solenoid)";
    url = "https://figma.com";
    profileName = "SolenoidLabsPablo";
    profileCategoryKey = "solenoidLabs";
    logoName = "figma";
  }
  {
    idName = "solenoid-labs-googledrive";
    siteName = "Google Drive (Solenoid)";
    url = "https://drive.google.com";
    profileName = "SolenoidLabsPablo";
    profileCategoryKey = "solenoidLabs";
    logoName = "googleDrive";
  }
  {
    idName = "solenoid-labs-github";
    siteName = "GitHub (Solenoid Labs)";
    url = "https://github.com/orgs/Solenoid-Labs/repositories";
    profileName = "SolenoidLabsPablo";
    profileCategoryKey = "solenoidLabs";
    logoName = "github";
  }

  # Academic Profile
  # -----------------------------------
  {
    idName = "academic-blackboard";
    siteName = "Blackboard";
    url = "https://www.ole.bris.ac.uk/ultra/institution-page";
    profileName = "Academic";
    profileCategoryKey = "academic";
    logoName = "blackboard";
  }

  # Key GitHub Repositories
  # -----------------------------------
  {
    idName = "phantom-github-repo";
    siteName = "GitHub Phantom Repo";
    url = "https://github.com/pabloagn/phantom";
    profileName = "TheHumanPalace";
    profileCategoryKey = "phantom";
    logoName = "github";
  }
  {
    idName = "rhodium-github-repo";
    siteName = "GitHub Rhodium Repo";
    url = "https://github.com/pabloagn/rhodium";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "github";
  }
  {
    idName = "scalpel-github-repo";
    siteName = "GitHub Scalpel Repo";
    url = "https://github.com/pabloagn/scalpel";
    profileName = "Personal";
    profileCategoryKey = "personal";
    logoName = "github";
  }
]

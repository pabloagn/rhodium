{
  apps = {
    # Core
    shell = "fish";
    shelAlt = "zsh";
    terminal = "kitty";
    terminalAlt = "ghostty";
    browser = "firefox";
    browserAlt = "brave";
    wm = "hyprland";

    # Files
    editor = "nvim";
    editorAlt = "hx";
    ide = "zeditor";
    ideAlt = "code";
    filesTerminal = "yazi";
    filesGraphic = "thunar";

    # Media
    imageViewer = "imv";
    videoPlayer = "mpv";
    audioPlayer = "mpv";

    # Productivity
    pdfViewer = "org.pwmt.zathura";
    pager = "most";
  };

  profiles = {
    firefox = {
      personal = "Personal";
      media = "Media";
      solenoidlabs = "SolenoidLabsPablo";
      uk = "UnitedKingdom";
      academic = "Academic";
      bsogood = "Bsogood";
      phantom = "TheHumanPalace";
      genai = "GenAI";
      genai-2 = "GenAI-2";
      amsterdam = "Amsterdam";
      ultra = "Ultra";
      segmentaim = "Segmentaim";
      littlejohn = "Little-John";
      atmosphericai = "AtmosphericAI";
      private = "Private";
    };

    zen = {
      personal = "Personal";
      work = "Work-Zen";
      media = "Entertainment";
      dev = "Dev-Profile";
    };

    chromium = {
      personal = "Default";
      work = "Work";
      media = "Media";
    };

    brave = {
      personal = "Person 1";
      work = "Work";
      media = "Media";
    };
  };
}

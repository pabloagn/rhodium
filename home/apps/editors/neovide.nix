{ ... }:

{
  programs.neovide = {
    enable = false;
    settings = {
      # Window behavior
      fork = false;
      frame = "full";
      idle = true;
      maximized = false;
      title-hidden = false;
      vsync = true;
      tabs = true;
      theme = "auto";
      
      # Performance & rendering
      srgb = false;
      no-multigrid = false;
      
      # Mouse
      mouse-cursor-icon = "arrow";
      
      # Font configuration - professional coding setup
      font = {
        normal = ["JetBrainsMono Nerd Font"];
        size = 12.0;
        hinting = "full";
        edging = "antialias";
        
        # Font features for better coding experience
        features = {
          "JetBrainsMono Nerd Font" = [
            "+ss01"  # Alternate a
            "+ss02"  # Alternate g
            "+ss03"  # Alternate r
            "+ss04"  # Dollar sign with line through
            "+ss05"  # Alternate at symbol
            "+ss06"  # Alternate 6 and 9
            "+ss07"  # Alternate l
            "+ss08"  # Better == != <= >=
            "+ss09"  # Better >>= <<= 
            "+ss19"  # Better dot operators
            "+ss20"  # Better ===
            "+calt"  # Contextual alternates
            "+liga"  # Standard ligatures
          ];
        };
      };
      
      # Box drawing for perfect terminal visuals
      box-drawing = {
        mode = "native";
        # sizes = {
        #   default = [1 2];  # Thin and thick lines
        #   12 = [1 2];
        #   14 = [1 3];
        #   16 = [2 3];
        #   18 = [2 4];
        # };
      };
      
      # Crash reporting
      backtraces_path = "~/.local/share/neovide/neovide_backtraces.log";
    };
  };
}

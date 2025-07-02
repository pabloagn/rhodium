{...}: {
  programs.neovide = {
    enable = false;
    settings = {
      # --- Window Behavior ---
      fork = false;
      frame = "full";
      idle = true;
      maximized = false;
      title-hidden = false;
      vsync = true;
      tabs = true;
      theme = "auto";

      # --- Performance & Rendering ---
      srgb = false;
      no-multigrid = false;

      # --- Mouse ---
      mouse-cursor-icon = "arrow";

      # --- Font Configuration ---
      font = {
        normal = ["JetBrainsMono Nerd Font"];
        size = 12.0;
        hinting = "full";
        edging = "antialias";

        # --- Font Features ---
        features = {
          "JetBrainsMono Nerd Font" = [
            "+ss01" # Alternate a
            "+ss02" # Alternate g
            "+ss03" # Alternate r
            "+ss04" # Dollar sign with line through
            "+ss05" # Alternate at symbol
            "+ss06" # Alternate 6 and 9
            "+ss07" # Alternate l
            "+ss08" # Better == != <= >=
            "+ss09" # Better >>= <<=
            "+ss19" # Better dot operators
            "+ss20" # Better ===
            "+calt" # Contextual alternates
            "+liga" # Standard ligatures
          ];
        };
      };

      # --- Box Drawing ---
      box-drawing = {
        mode = "native";
      };

      # --- Crash Reporting ---
      backtraces_path = "~/.local/share/neovide/neovide_backtraces.log";
    };
  };
}

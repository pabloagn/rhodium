{...}: {
  programs.ghostty = {
    settings = {
      # General
      resize-overlay = "never";
      link-url = true;
      scrollback-limit = 1000000000;

      # Theme
      theme = "kanso";

      # Typography
      font-family = "JetBrains Mono";
      font-style = "Regular";
      # font-size = 13;

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false; # Enforce no blinking (shell vi mode can interfere)
      shell-integration-features = "no-cursor";
      adjust-cursor-thickness = "2"; # Make cursor line thicker

      # Clipboard
      clipboard-read = "allow";
      clipboard-write = "allow";

      # UI
      window-padding-x = 20;
      window-padding-y = 10;
      window-padding-balance = true;
      background-opacity = 1.0; # This is controlled by the compositor instead
      background-blur = 20;
      mouse-hide-while-typing = true;

      # Performance
      linux-cgroup-memory-limit = 0;
    };
  };
}

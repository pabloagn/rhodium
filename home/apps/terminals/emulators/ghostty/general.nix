{...}:
# TODO: Tidy this up
{
  programs.ghostty = {
    settings = {
      # General
      # theme = "chiaroscuro";
      theme = "kanso";

      # Font
      font-style = "Regular";
      # font-size = 13;
      # font-thicken = true;

      # Typography
      # font-family = "JetBrainsMono";
      font-family = "JetBrains Mono";
      # font-family = "IosevkaTerm NF";
      # font-family = "FiraCode Nerd Font Mono Med";
      # font-family = "JuliaMono";

      # Cursor
      # Enforce no blinking (shell vi mode can interfere)
      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";
      adjust-cursor-thickness = "2"; # Make cursor line thicker

      # Clipboard
      clipboard-read = "allow";
      clipboard-write = "allow";
      window-padding-x = 20;
      window-padding-y = 10;
      window-padding-balance = true;
      background-opacity = 0.9;
      background-blur = 20;

      resize-overlay = "never";
      mouse-hide-while-typing = true;
      link-url = true;
      scrollback-limit = 1000000000;

      # font-feature = "calt" "liga" "dlig";

      # Performance
      linux-cgroup-memory-limit = 0;
    };
  };
}

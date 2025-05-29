{ config, pkgs, ... }:
# TODO: Tidy this up
{
  programs.ghostty = {
    settings = {
      # General
      theme = "chiaroscuro";

      # Font
      font-style = "Regular";
      # font-size = 13;
      # font-thicken = true;

      # Cursor
      cursor-style = "bar";
      cursor-style-blink = false;

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

      # Typography
      # font-family = "JetBrainsMono";
      font-family = "JetBrains Mono";
      # font-family = "IosevkaTerm NF";
      # font-family = "FiraCode Nerd Font Mono Med";
      # font-family = "JuliaMono";

      # font-feature = "calt" "liga" "dlig";

      # Performance
      linux-cgroup-memory-limit = 0;
    };
  };
}

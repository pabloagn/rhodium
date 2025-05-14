{ config, pkgs, lib, ... }: {
  services.dunst = {
    enable = true;
    # Option 1: Inline settings
    # settings = {
    #   global = {
    #     monitor = 0;
    #     follow = "mouse";
    #     # ... other dunst settings
    #   };
    #   urgency_low = {
    #     background = "#222222";
    #     foreground = "#888888";
    #     timeout = 10;
    #   };
    # };

    # Option 2: Link to a dunstrc file
    # Ensure this file exists, e.g., home/features/desktop/dunst/dunstrc
    configFile = ./dunstrc;
  };
  # xdg.configFile."dunst/dunstrc".source = ./dunstrc; # Alternative if not using services.dunst.configFile
}

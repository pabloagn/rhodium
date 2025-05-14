{ config, pkgs, lib, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # Ensure Wayland variant for Hyprland
    # themes = [ ... ]; # You can define themes here or link a config
    # extraConfig = {
    #   modi = "drun,run,window";
    #   show-icons = true;
    # };

    # Option: Link to a Rofi config file (e.g., config.rasi)
    # Ensure this file exists, e.g., home/features/desktop/rofi/config.rasi
    # This often includes theme imports.
    # configPath = ".config/rofi/config.rasi"; # Default path
    # home.file.".config/rofi/config.rasi".source = ./config.rasi;
  };

  # Example: Create a config.rasi if you want to manage it with Nix
  # xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
  # xdg.configFile."rofi/themes/mytheme.rasi".source = ./rofi/mytheme.rasi;
}

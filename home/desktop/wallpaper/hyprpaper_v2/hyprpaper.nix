# ---------------------------------------------------------
# Route:............/user/desktop/hypr/hyprpaper.nix
# Type:.............Module
# Created by:.......Pablo Aguirre
# ---------------------------------------------------------

{ config, pkgs, ... }:

{
  # ------------------------------------------
  # Requirements
  # ------------------------------------------
  home.packages = with pkgs; [
    hyprpaper
  ];

  # ------------------------------------------
  # Program Options
  # ------------------------------------------
  xdg.configFile."hypr/hyprpaper.conf" = {
		  source = ./hyprpaper.conf;
	 };
}

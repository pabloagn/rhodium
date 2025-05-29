{ pkgs, ... }:

{
  programs.rofi = {
    enable = false;
    package = pkgs.rofi-wayland;
  };

  xdg.configFile."rofi/themes/chiaroscuro.rasi" = {
		  source = ./rofi/themes/chiaroscuro.rasi;
	 };
}

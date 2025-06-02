{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  xdg.configFile."rofi/themes/chiaroscuro.rasi" = {
		  source = ./rofi/themes/chiaroscuro.rasi;
	 };
}

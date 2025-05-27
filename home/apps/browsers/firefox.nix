{ config, pkgs, pkgs-unstable, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # package = pkgs-unstable.firefox-devedition;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tridactyl
      ];
      settings = {
        # Optional: disable smooth scrolling for snappier vim movement
        "general.smoothScroll" = true;
        "accessibility.browsewithcaret" = true;
      };
    };
  };
}

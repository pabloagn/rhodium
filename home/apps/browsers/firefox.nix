{ pkgs, pkgs-unstable, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # package = pkgs-unstable.firefox-devedition;
    profiles.default = {
      extensions = with inputs.nur.legacyPackages.${pkgs.system}.repos.rycee.firefox-addons; [
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

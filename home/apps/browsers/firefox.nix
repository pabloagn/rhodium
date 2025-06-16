{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    # TODO: Set this up, but need to manage the profiles completely declarative as well, since default wants to write to profiles.ini
    # profiles.default = {
    #   extensions = with inputs.nur.legacyPackages.${pkgs.system}.repos.rycee.firefox-addons; [
    #     tridactyl
    #   ];
    #   settings = {
    #     # Optional: disable smooth scrolling for snappier vim movement
    #     "general.smoothScroll" = true;
    #     "accessibility.browsewithcaret" = true;
    #   };
    # };
  };
}

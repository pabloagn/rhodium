{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kmonad
  ];

  xdg.configFile = {
    "kmonad/justine.kbd" = {
      source = ./kmonad/justine.kbd;
    };
    "kmonad/alexandria.kbd" = {
      source = ./kmonad/alexandria.kbd;
    };
    "kmonad/keychron.kbd" = {
      source = ./kmonad/keychron.kbd;
    };
    "kmonad/keychron-q3.kbd" = {
      source = ./kmonad/keychron-q3.kbd;
    };
  };
}

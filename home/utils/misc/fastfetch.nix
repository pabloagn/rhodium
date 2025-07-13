{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch # Faster disfetch
  ];

  xdg.configFile."fastfetch/config.jsonc" = {
    source = ./fastfetch/config.jsonc;
    force = true;
  };
}

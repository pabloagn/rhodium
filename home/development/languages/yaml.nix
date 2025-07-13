{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Yaml ---
    yaml-language-server
  ];
}

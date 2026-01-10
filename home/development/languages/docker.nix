{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Docker ---
    dockfmt # Docker formatter
    dockerfile-language-server
  ];
}

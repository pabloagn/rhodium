{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Docker ---
    dockfmt # Docker formatter
    nodePackages.dockerfile-language-server-nodejs
  ];
}

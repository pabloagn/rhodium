{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # discord
    discordo
    vesktop # NOTE: We use another client that has better Wayland support
  ];
}

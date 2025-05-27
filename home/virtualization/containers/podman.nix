{ pkgs, ... }:

{
  home.packages = with pkgs; [
    podman-tui
  ];
  services.podman = {
    enable = true;
  };
}

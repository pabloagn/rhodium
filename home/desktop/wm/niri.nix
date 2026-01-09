{ pkgs, ... }:
{
  imports = [
    ./niri
  ];

  home.packages = with pkgs; [
    wl-mirror # Mirror client for wayland (Niri does not support mirroring)
  ];

  # KDL config symlink disabled - now using declarative Nix configuration
  # The KDL file is kept in the repo as a reference/backup
  # xdg.configFile."niri/config.kdl" = {
  #   source = ./niri/config.kdl;
  #   force = true;
  # };
}

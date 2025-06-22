{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-mirror # Mirror client for wayland (Niri does not support mirroring)
  ];
  # xdg.configFile."niri/config.kdl" = {
  #   source = ./niri/config.kdl;
  #   force = true;
  # };
}

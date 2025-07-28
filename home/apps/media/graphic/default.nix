{ pkgs, ... }:
{
  imports = [
    ./imv.nix
    ./oculante.nix
    ./swayimg.nix
  ];

  home.packages = with pkgs; [
    darktable # Professional photo management & editing
    djv # Used to view EXR sequences
    exiv2 # Manage image metadata
    # feh # Image visualizer (X11)
    handbrake # Converting video formats & ripping DVDs
    kdePackages.kdenlive # Video editing software
    mpv # Media player
    obs-studio # Recorder
    vlc # Video player
    yt-dlp # CLI tool for downloading yt content
  ];
}

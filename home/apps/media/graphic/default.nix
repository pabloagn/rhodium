{pkgs, ...}: {
  home.packages = with pkgs; [
    djv # Used to view EXR sequences
    exiv2 # Manage image metadata
    feh # Image visualizer
    handbrake # Converting video formats & ripping DVDs
    mpv # Media player
    obs-studio # Recorder
    vlc # Video player
    yt-dlp # CLI tool for downloading yt content
  ];
}

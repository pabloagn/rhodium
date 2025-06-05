{ pkgs, ... }:

{
  home.packages = with pkgs; [
    djv # Used to view EXR sequences
    exiv2
    feh # Image visualizer
    handbrake # Converting video formats & ripping DVDs
    mpv # Media player
    obs-studio # Recorder
    vlc # Video player
    yt-dlp
  ];
}

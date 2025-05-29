{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # -----------------------------------
    # Audio & Music
    # -----------------------------------
    # audacious
    # audacity
    easyeffects # Equalizer for PipeWire
    playerctl
    spotify
    spotify-player # Terminal spotify player that has feature parity with the official client
    tidal-hifi # Tidal GUI running on Electron
    tidal-dl

    # -----------------------------------
    # Creative & Design
    # -----------------------------------
    blender
    figma-linux # Unofficial Figma client for Linux
    inkscape

    # -----------------------------------
    # Image & Video
    # -----------------------------------
    djv # Used to view EXR sequences
    exiv2
    feh
    sxiv
    handbrake # A tool for converting video formats & ripping DVDs
    mpv
    obs-studio
    vlc
    yt-dlp

    # -----------------------------------
    # Media Centers & Streaming
    # -----------------------------------
    plex
    plexamp

    # -----------------------------------
    # File Sharing & Downloads
    # -----------------------------------
    transmission_4-qt # Transmission GUI
    qbittorrent

    # -----------------------------------
    # Utilities & Launchers
    # -----------------------------------
    ulauncher
  ];
}

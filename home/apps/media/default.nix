{ pkgs, ... }:
# TODO: Organize this
{
  home.packages = with pkgs; [
    audacious
    audacity
    blender

    # A professional review software for VFX, animation, and film production
    # Used to view EXR sequences
    # djv

    # Equalizer for PipeWire
    easyeffects

    exiv2
    feh
    # Unofficial Figma client for Linux
    figma-linux

    # A tool for converting video formats & ripping DVDs
    handbrake

    imagemagick
    inkscape
    mpv
    obs-studio

    # Plex
    # Plex server
    plex

    # Plex amp
    plexamp

    playerctl
    spotify

    # Tidal GUI running on Electron
    tidal-hifi

    # Transmission GUI
    transmission_4-qt

    # QBitorrent
    # qbittorrent

    sxiv
    tidal-dl
    ulauncher
    vlc
    yt-dlp
  ];
}

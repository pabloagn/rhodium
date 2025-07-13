{ pkgs, ... }:
{
  imports = [
    ./ncspot.nix
    # ./puredata.nix
  ];

  home.packages = with pkgs; [
    # audacious
    # audacity
    clementine
    easyeffects # Equalizer for PipeWire
    helvum # GTK patchbay for PipeWire
    playerctl
    spotify
    # spotify-player # Terminal spotify player that has feature parity with the official client
    tidal-dl # Downloader for tidal media
    tidal-hifi # Tidal GUI running on Electron

    # --- Music Production ---
    # vcv-rack
    # supercollider
    # csound
  ];
}

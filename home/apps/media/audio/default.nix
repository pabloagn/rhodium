{ pkgs, ... }:

{
  imports = [
    ./ncspot.nix
  ];

  home.packages = with pkgs; [
    # audacious
    # audacity
    clementine
    easyeffects # Equalizer for PipeWire
    playerctl
    spotify
    # spotify-player # Terminal spotify player that has feature parity with the official client
    tidal-hifi # Tidal GUI running on Electron
    tidal-dl
  ];
}

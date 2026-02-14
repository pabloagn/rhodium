{ pkgs, ... }:
{
  imports = [
    ./csound.nix
    ./ncmpc.nix
    ./ncspot.nix
    ./puredata.nix
    ./rmpc.nix
    ./sonicpi.nix
    ./spotify.nix
    ./supercollider.nix
    ./tidal.nix
    ./tidalcycles.nix
    ./vcv-rack.nix
  ];

  home.packages = with pkgs; [
    # audacious
    # audacity
    clementine
    easyeffects # Equalizer for PipeWire
    helvum # GTK patchbay for PipeWire
    playerctl # CLI util & lib for controlling audio
    cavalier # Terminal audio visualizer

    # --- TUI Music Players ---
    termusic # Feature-rich music player in Rust
    cmus # Small, fast console music player

    # --- Roon ---
    roon-tui # TUI remote control for Roon
    roon-bridge # Roon audio output endpoint
  ];
}

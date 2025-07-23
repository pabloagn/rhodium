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
    playerctl
  ];
}

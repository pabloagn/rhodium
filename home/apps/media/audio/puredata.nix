{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maxl # PureData non-tilde externals
    puredata # Real time interface for audio & video signal processing
    timbreid # PureData Utils
    zexy # PureData utils
  ];
}

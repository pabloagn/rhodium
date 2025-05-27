{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    #TODO: Pull from Home/assets/fonts/fonts.nix

    # Monospace
    fira-code
    fira-code-symbols
    hack-font
    ibm-plex
    jetbrains-mono
    julia-mono
    roboto-mono
    office-code-pro
    inconsolata
    hack-font
    cascadia-code
    paratype-pt-mono

    # Sans-serif
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    work-sans
    roboto
    raleway
    quicksand
    lato
    dosis
    open-sans
    montserrat
    source-sans-pro
    libre-franklin

    # Serif
    cardo
    merriweather
    garamond-libre
    crimson
    gelasio

    # Symbols
    font-awesome
    powerline-fonts
    powerline-symbols
    nerdfonts
  ];
}

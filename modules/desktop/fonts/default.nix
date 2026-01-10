{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # Monospace
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code

    fira-mono
    nerd-fonts.fira-mono

    hack-font
    nerd-fonts.hack

    ibm-plex
    nerd-fonts.blex-mono

    jetbrains-mono
    nerd-fonts.jetbrains-mono

    julia-mono
    roboto-mono
    nerd-fonts.roboto-mono

    office-code-pro
    inconsolata

    cascadia-code
    nerd-fonts.caskaydia-cove

    # Iosevka Family
    iosevka
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.zed-mono

    paratype-pt-mono

    # Sans-serif
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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
  ];
}

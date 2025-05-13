/*
* Route: /common/system/interface/fonts.nix
* Type: Module
* Created by: Pablo Aguirre
*/

{ config, pkgs, lib, ... }:

{
  fonts.packages = with pkgs; [

    # Monospace
    # -----------------------------
    fira-code
    fira-code-symbols
    hack-font
    ibm-plex
    jetbrains-mono
    roboto-mono
    office-code-pro
    inconsolata
    hack-font
    cascadia-code
    paratype-pt-mono
    
    # Monospace - Premium
    # -----------------------------
    commit-mono
    fragment-mono
    departure-mono
    iosevka
    julia-mono
    
    # Pendings to Add
    # -----------------------------
    # Recursive Mono
    # TX-02 Berkeley Mono
    # Geist Mono
    # Operator Mono
    # PragmataPro
    # Ingram Mono
    # Dank Mono
    # Monolisa
    # Cartograph CF
    # Covik Sans Mono
    # SF Mono Square
    # Server Mono
    # Knif Mono


    # Sans-serif
    # -----------------------------
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
    # -----------------------------
    cardo
    lora
    merriweather
    garamond-libre
    crimson
    crimson-pro
    gelasio

    # Symbols
    # -----------------------------
    font-awesome
    powerline-fonts
    powerline-symbols
    nerdfonts

    # Custom Fonts
    # -----------------------------
    customFonts.serverMono
  ];
}

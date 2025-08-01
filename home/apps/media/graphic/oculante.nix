{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    oculante # Portable image viewer and editor written in Rust
  ];

  home.file."${config.home.homeDirectory}/.local/share/oculante/config.json" = {
    source = ./oculante/config.json;
  };
}

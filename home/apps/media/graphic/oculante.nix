{ pkgs, ... }:
{
  home.packages = with pkgs; [
    oculante # Portable image viewer and editor written in Rust
  ];

  # xdg.configFile = {
  #   "imv/config" = {
  #     source = ./imv/config;
  #   };
  # };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    whatsapp-for-linux
    telegram-desktop
  ];
}

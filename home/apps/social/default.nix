{pkgs, ...}: {
  home.packages = with pkgs; [
    signal-desktop
    telegram-desktop
  ];
}

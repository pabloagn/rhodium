{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Messaging & Collaboration
    # ------------------------------------------
    slack
    # teams # Not available on this platform...
    teams-for-linux

    # Document Processing and Viewing
    # ------------------------------------------
    libreoffice
    onlyoffice-desktopeditors
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Messaging & Collaboration
    slack
    teams-for-linux

    # Document Processing and Viewing
    libreoffice
    onlyoffice-desktopeditors
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Messaging & Collaboration
    # ------------------------------------------
    slack
    teams
    # teams-for-linux

    # Document Processing and Viewing
    # ------------------------------------------
    libreoffice
    onlyoffice-bin
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    # Messaging & Collaboration
    slack
    teams-for-linux
    # jitsi-meet
    zoom-us

    # Document Processing and Viewing
    libreoffice
    onlyoffice-desktopeditors
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    # Messaging & Collaboration
    slack
    teams-for-linux
    jitsi-meet

    # Document Processing and Viewing
    libreoffice
    onlyoffice-desktopeditors
  ];
}

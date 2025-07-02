{pkgs, ...}: {
  home.packages = with pkgs; [
    # --- Messaging & Collaboration ---
    slack
    teams-for-linux
    zoom-us

    # --- Document Processing And Viewing ---
    libreoffice
    onlyoffice-desktopeditors
  ];
}

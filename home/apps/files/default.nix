{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

  # Backup and File Transfer
  # ------------------------------------------
  filezilla # FTP client
  celeste # A file sync client supporting ProtonDrive

  # Browsers and File Managers
  # ------------------------------------------
  # krusader # The heavy-duty option
  xfce.thunar # The in-between option
  # pcmanfm # The efficient option
  ];
}


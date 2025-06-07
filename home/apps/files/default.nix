{ pkgs, ... }:

{
  imports = [
    # ./krusader.nix # The heavy-duty option
    # ./pcmanfm.nix # The efficient option
    ./thunar # The in-between option
  ];

  home.packages = with pkgs; [
    # Backup and File Transfer
    filezilla # FTP client
    celeste # File sync client supporting ProtonDrive
  ];
}

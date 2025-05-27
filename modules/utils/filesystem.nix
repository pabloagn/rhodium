{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dua                   # Interactive disk usage analyzer
    dust                  # Modern du replacement with colors
    eza                   # Modern ls replacement
    file                  # Determine file types
    ncdu                  # NCurses disk usage analyzer
    p7zip                 # 7-Zip archiver
    tree                  # Directory tree viewer
    unzip                 # Extract ZIP archives
    yazi                  # Terminal file manager
    zip                   # Create ZIP archives
  ];
}

# modules/core/utils/utils.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jq         # JSON processor
    ripgrep    # Fast grep alternative
    fd         # Fast find alternative
    htop       # Interactive process viewer
    curl       # Command-line tool for transferring data with URL syntax
    wget       # Non-interactive network downloader
    git        # Version control system
    unzip      # For extracting zip files
    p7zip      # For 7zip archives
  ];
}

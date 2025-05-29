{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dua # Interactive disk usage analyzer
    dust # Modern du replacement with colors
    eza # Modern ls replacement
    file # Determine file types
    ncdu # NCurses disk usage analyzer
    p7zip # 7-Zip archiver
    # tree # Directory tree viewer (use eza instead)
    unzip # Extract ZIP archives
    rar # RAR archives
    zstd # Compression algorithm (optional Emacs dep)
    zip # Create ZIP archives
    lsof # Tool to list open files
  ];
}

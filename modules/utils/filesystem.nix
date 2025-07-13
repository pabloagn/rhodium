{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dua # Interactive disk usage analyzer
    dust # Modern du replacement with colors
    eza # Modern ls replacement
    file # Determine file types
    gawk # GNU's awk
    lsof # Tool to list open files
    ncdu # NCurses disk usage analyzer
    p7zip # 7-Zip archiver
    rar # RAR archives
    unzip # Extract ZIP archives
    zip # Create ZIP archives
    zstd # Compression algorithm (optional Emacs dep)
  ];
}

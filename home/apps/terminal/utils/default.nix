# home/apps/terminal/utils/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal.utils;
in
{
  imports = [
    ./bat.nix
    ./lf.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  options.rhodium.apps.terminal.utils = {
    enable = mkEnableOption "Rhodium's terminal utils";
  };

  config = mkIf cfg.enable {

    rhodium.apps.terminal.utils.bat.enable = true;
    rhodium.apps.terminal.utils.lf.enable = true;
    rhodium.apps.terminal.utils.yazi.enable = true;
    rhodium.apps.terminal.utils.zoxide.enable = true;

    home.packages = with pkgs; [
      hexyl # Hex viewer
      eza # Modern ls & exa replacement
      less # Pager

      # Search tools
      fd # Better find
      ripgrep # Better grep
      fzf # Fuzzy finder
      silver-searcher # Fast code searching tool (ag)

      # JSON/YAML/Data processing
      jq # JSON processor
      yq # YAML processor
      xsv # CSV processing
      dasel # Query and modify data structures (JSON, TOML, YAML, XML)

      # System monitoring
      btop # Resource monitor
      htop # Process viewer
      bottom # Yet another terminal-based graphical process/system monitor
      glances # System monitoring tool
      dua # Disk usage analyzer
      du-dust # More intuitive du
      ncdu # Disk usage analyzer with ncurses interface

      # System information
      disfetch # Minimal system info
      onefetch # Git repository summary
      hwinfo # Hardware information
      dmidecode # DMI table decoder
      lshw # Hardware lister
      pciutils # PCI utilities
      usbutils # USB utilities
      inxi # System information script

      # File operations
      sd # Sed alternative
      rsync # Fast file copying tool
      rclone # Manage files on cloud storage
      rename # Rename files
      zoxide # Smarter cd command

      # Compression
      zip
      unzip
      rar
      p7zip
      zstd
      gzip
      bzip2
      xz

      # Network tools
      curl
      wget
      httpie # User-friendly HTTP client
      dog # DNS client like dig
      mtr # Traceroute and ping in one
      nmap # Network scanner
      bandwhich # Network utilization tool
      iperf # Network bandwidth testing
      socat # Multipurpose relay

      # Git tools
      git
      git-lfs
      gitui # Terminal UI for git
      lazygit # Simple terminal UI for git
      delta # Better git diffs

      # Terminal tools
      glow # Markdown renderer
      tldr # Simplified man pages
      cheat # Create and view interactive cheatsheets
      tmux # Terminal multiplexer
      asciinema # Terminal recorder
      tree # Directory listing
      navi # Interactive cheatsheet
      mcfly # Enhanced shell history

      # Security
      age # Simple encryption tool
      gnupg # OpenPGP implementation
      gnutls

      # Misc
      bc # Calculator
      binutils # GNU binary tools
      entr # Run commands when files change
      parallel # Execute commands in parallel
      progress # Shows progress of coreutils commands
      pv # Pipe viewer
    ];
  };
}

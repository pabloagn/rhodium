# home/profiles/desktop.nix

{ config, lib, pkgs, rhodium, ... }: { # rhodium gives access to flakeOutputs.rhodium
  imports = [
    # Import features/modules for the desktop experience
    ../features/desktop/hyprland.nix
    ../features/desktop/dunst.nix
    ../features/desktop/rofi.nix
    ../features/desktop/kitty.nix
    ../features/desktop/waybar.nix
    ../features/desktop/gtk.nix
    ../features/apps/git.nix
    # TODO: Add other features like browser, editor, etc.
  ];

  # Default shell for desktop users
  programs.zsh.enable = true; # Or bash, fish

  # Basic home directory structure
  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/Desktop"
    XDG_DOCUMENTS_DIR="$HOME/Documents"
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
    XDG_MUSIC_DIR="$HOME/Music"
    XDG_PICTURES_DIR="$HOME/Pictures"
    XDG_PUBLICSHARE_DIR="$HOME/Public"
    XDG_TEMPLATES_DIR="$HOME/Templates"
    XDG_VIDEOS_DIR="$HOME/Videos"
  '';
  home.packages = with pkgs; [
    # Common utilities
    pavucontrol # Volume control for PulseAudio/PipeWire
    networkmanagerapplet # For managing network connections via GUI
    # Your color-provider tool if it's a CLI for users
    # rhodium.packages.${pkgs.system}.color-provider # Accessing via flake outputs
  ];
}

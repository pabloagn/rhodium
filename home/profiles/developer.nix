# home/profiles/developer.nix

{ config, lib, pkgs, ... }:

{
  programs.home-manager.enable = true;
  # TODO: Set dynamically
  home.stateVersion = "24.11";

  home.username = "pabloagn";
  # This needs to match the user it's applied to
  # TODO: Of course set dynamically by Home Manager's NixOS module

  home.packages = with pkgs; [
    # Developer tools
    gcc
    gnumake
    python3
    nodejs
    rustup
  ];

  programs.git = {
    enable = true;
    userName = "Developer";
    userEmail = "developer@example.com";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Add developer-specific extensions
      ms-vscode.cpptools
      ms-python.python
    ];
  };

  # Alacritty is themed by modules/themes/apply.nix, but enabled here
  programs.alacritty.enable = true;

  # Example: Zsh config (if user pabloagn uses zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = false; # Example: using pure zsh or other plugin managers
    # .zshrc content or plugins
  };
}

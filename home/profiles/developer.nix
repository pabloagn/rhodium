# home/profiles/developer.nix

{ pkgs, config, lib, ... }:

{
  programs.home-manager.enable = true;
  # TODO: Set dynamically
  home.stateVersion = "23.11";

  home.username = "pabloagn";
  # This needs to match the user it's applied to
  # TODO: Of course set dynamically by Home Manager's NixOS module

  home.packages = with pkgs; [ git neovim ripgrep fd ];

  programs.git = {
    enable = true;
    userName = "Pablo Aguirre";
    userEmail = "pablo@example.com"; # Replace with your email
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

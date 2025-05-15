# modules/core/shell/shell.nix
{ config, pkgs, lib, ... }:

{
  # Install Zsh and Bash system-wide
  environment.shells = with pkgs; [ zsh bash ];

  # Set Zsh as the default shell for NEW users created by NixOS.
  # The users.users.pabloagn.shell setting overrides this for pabloagn.
  users.defaultUserShell = pkgs.zsh;

  # Make Zsh available system-wide for use by programs/scripts if needed
  # and enable system-wide zsh configuration (e.g. /etc/zshrc).
  # This doesn't necessarily conflict with Home Manager's Zsh config,
  # as HM configures ~/.zshrc.
  programs.zsh.enable = true;

  # Starship prompt (optional, user can override with Home Manager)
  # If you want it available system-wide for all users by default:
  environment.systemPackages = with pkgs; [
    starship
  ];

  # Optional: configure a basic /etc/zshrc if desired for system users
  # environment.etc."zshrc".text = ''
  #   # System-wide Zsh config
  #   if [ -f /etc/zsh/zshrc.zni ]; then
  #     source /etc/zsh/zshrc.zni
  #   fi
  #   # Add starship init if you want it for all users by default in system zshrc
  #   if command -v starship &> /dev/null; then
  #     eval "$(starship init zsh)"
  #   fi
  # '';
}

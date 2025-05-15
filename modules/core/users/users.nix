# modules/core/users/users.nix

{ config, pkgs, ... }:

{
  users.users.pabloagn = {
    isNormalUser = true;
    description = "Pablo Aguirre";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ]; # Added common groups
    # Per-user packages are generally better handled by Home Manager,
    # but if you have system-level tools specific to this user only, they can go here.
    # packages = with pkgs; [];
    shell = pkgs.zsh; # Ensure Zsh is set as default shell here
  };
}

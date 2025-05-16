# modules/core/users/users.nix

{ config, pkgs, ... }:

{
  users.users.pabloagn = {
    isNormalUser = true;
    description = "Pablo Aguirre";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell = pkgs.zsh;
  };
}

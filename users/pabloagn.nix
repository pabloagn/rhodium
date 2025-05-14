# users/pabloagn.nix

{ config, pkgs, lib, ... }:

{
  users.users.pabloagn = {
    isNormalUser = true;
    description = "Pablo Aguirre";

    # Which groups does user belong to?
    extraGroups = [ "wheel" "networkmanager" "docker" "adbusers" ];

    # Which is the user's prefered login shell?
    # It will override system defaultif set
    # Must be in mySystem.userShells.enable for this host
    shell = pkgs.zsh;

    # TODO: Use sops-nix for hashedPasswords in production for security
    # initialPassword = "replace_this_insecure_password"; # For testing only
  };
}

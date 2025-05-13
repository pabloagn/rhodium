# users/pabloagn.nix
{
  users.users.username = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Control which development tools the user receives
  myCompany.devAccess.username = {
    webStack.enable = true;
    dataScience.enable = false;
  };
}

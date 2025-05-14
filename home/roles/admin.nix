# home/roles/admin.nix

{ config, lib, pkgs, ... }:

{
  # Admin-specific role configuration
  home.file.".sudo_as_admin_successful".text = "";

  programs.bash.shellAliases = {
    sysctl = "sudo systemctl";
    jctl = "sudo journalctl";
  };
}

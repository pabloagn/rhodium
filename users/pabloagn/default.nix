# users/pabloagn/default.nix

{ inputs, pkgs, lib, config, flakeOutputs, self, ... }:

{
  imports = [
    flakeOutputs.rhodium.home.desktop
    flakeOutputs.rhodium.home.development
  ];

  # Profile
  # ------------------------------------
  home.username = "pabloagn";
  home.homeDirectory = "/home/pabloagn";

  # Assets
  # ------------------------------------
  home.file.".local/share/rhodium/assets" = {
    source = self + "/assets";
    recursive = true;
  };

  # Scripts
  # ------------------------------------
  home.file.".local/bin/rhodium/scripts" = {
    source = self + "/scripts";
    recursive = true;
    executable = true;
  };

  # Options
  # ------------------------------------

  # Desktop
  rhodium.desktop.wm.hyprland.enable = true;
  rhodium.desktop.launcher.rofi.enable = true;

  # Development
  rhodium.development.enable = true;
  rhodium.development.enabledLanguages = [ "nix" "rust" "go" "python" "c" "cpp"];


  # State
  # ------------------------------------
  home.stateVersion = "24.11";
}

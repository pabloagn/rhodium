# modules/desktop/terminal/default.nix

{ lib, config, pkgs, ... }:

{
  imports = [
    # ./ghostty.nix ./kitty.nix ./wezterm.nix etc.
  ];
  config = lib.mkIf (config.mySystem.hostProfile == "gui-desktop" || config.mySystem.hostProfile == "headless-dev") {
    environment.systemPackages = lib.mapAttrsToList (name: value: pkgs."${name}")
      (lib.filterAttrs (name: value: lib.elem name config.mySystem.userTerminals.enable) {
        ghostty = pkgs.ghostty;
        kitty = pkgs.kitty;
        wezterm = pkgs.wezterm;
        alacritty = pkgs.alacritty;
        foot = pkgs.foot;
      });
  };
}

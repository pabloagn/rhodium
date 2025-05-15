# modules/development/editors/nvim.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
  ];
}

# modules/development/editors/vim.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
  ];
}

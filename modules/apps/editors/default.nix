{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    helix
  ];
}

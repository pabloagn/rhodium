{ config, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
    };
    vim = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    helix
  ];
}

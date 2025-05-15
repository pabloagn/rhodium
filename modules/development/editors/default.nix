# modules/development/editors/default.nix

{ config, pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./nvim.nix
  ];
}

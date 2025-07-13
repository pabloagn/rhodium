{ pkgs, ... }:
{
  imports = [
    ./qemu.nix
  ];

  home.packages = with pkgs; [
    # virtualbox
    # wine
    # darling
  ];
}

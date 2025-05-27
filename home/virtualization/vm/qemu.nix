{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qemu
    kvmtools
  ];
}

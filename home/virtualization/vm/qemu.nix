{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qemu
    kvmtool
  ];
}

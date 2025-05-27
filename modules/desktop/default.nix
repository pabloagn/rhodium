{ config, pkgs, ... }:

{
  imports = [
    ./bar
    ./fonts
    ./files
    ./notifications
  ];
}

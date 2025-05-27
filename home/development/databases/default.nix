{ pkgs, ... }:

{
  home.packages = with pkgs; [
    redis
    postgresql
    dbeaver-bin
  ];
}

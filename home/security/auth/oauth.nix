{ pkgs, ... }:
{
  home.packages = with pkgs; [
    authentik # Authentication glue
  ];
}

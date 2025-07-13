{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dunst
  ];
}

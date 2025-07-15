{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
  ];
}

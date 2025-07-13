{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
  ];
}

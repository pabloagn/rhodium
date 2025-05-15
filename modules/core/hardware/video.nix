# modules/core/hardware/video.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}

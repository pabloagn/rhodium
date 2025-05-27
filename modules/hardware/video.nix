

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    wdisplays # GUI for exploring and setting monitor options
  ];
}

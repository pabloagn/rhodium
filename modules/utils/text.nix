{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep # Better grep
    fd # Better find
    jq # JSON processor
  ];
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty # NOTE: Kitty is always installed as main
  ];

  programs.foot = {
    enable = true; # NOTE: Foot is always installed as fallback
  };
}

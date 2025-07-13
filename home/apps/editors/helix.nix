{ pkgs, ... }:
{
  imports = [
    ./helix
  ];

  programs.helix = {
    enable = true;
    # package = pkgs.helix;
    package = pkgs.evil-helix;
  };
}

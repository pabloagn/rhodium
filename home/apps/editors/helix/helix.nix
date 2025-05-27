{ pkgs, ... }:

{
  imports = [
    ./modules
  ];

  programs.helix = {
    enable = true;
    package = pkgs.helix;
    # package = pkgs.evil-helix;
  };
}

{ pkgs, ... }:
{
  imports = [
    ./protonmail.nix
    # ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    aerc # Modern terminal email client
  ];
}

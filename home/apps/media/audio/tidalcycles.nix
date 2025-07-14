{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.tidal
  ];
}

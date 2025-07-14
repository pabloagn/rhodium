{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.tidal
    haskellPackages.tidal-vis
  ];
}

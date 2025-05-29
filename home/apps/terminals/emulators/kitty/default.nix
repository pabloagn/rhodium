{ pkgs, lib, ... }:

{
  programs.kitty = {
    settings = lib.mkMerge [
      (import ./settings.nix)
      (import ./themes/chiaroscuro.nix)
    ];
  };
}

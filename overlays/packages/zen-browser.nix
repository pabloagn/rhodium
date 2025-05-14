# overlays/packages/zen-browser.nix

final: prev:

let
  inherit (final) system;
in
{
  zen-browser = final.zen-browser-flake.packages.${system}.default;
}

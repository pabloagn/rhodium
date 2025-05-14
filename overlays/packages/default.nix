# overlays/packages/default.nix

final: prev:

let
  # Import all package overlays
  custom-fonts = import ./custom-fonts.nix final prev;
  zen-browser = import ./zen-browser.nix final prev;
  # TODO: Import other package overlays...
in
  # Merge all package overlays
  custom-fonts //
  zen-browser //
  # TODO: Other package overlays...
  {}

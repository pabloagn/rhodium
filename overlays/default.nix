# overlays/default.nix

{ inputs }:

let
  # Create an overlay that adds the flake input to pkgs
  # This makes it accessible to other overlays
  flakeInputsOverlay = final: prev: {
    zen-browser-flake = inputs.zen-browser;
  };

  # Import all package overlays
  packageOverlays = import ./packages;

  # Import service overlays
  serviceOverlays = import ./services;

  # Import fixes overlays
  fixesOverlays = import ./fixes;

in
  # Compose all overlays in the right order
  final: prev:
    (flakeInputsOverlay final prev) //
    (packageOverlays final prev) //
    (serviceOverlays final prev) //
    (fixesOverlays final prev)

# assets/tokens/semantic/default.nix

{ lib, resolvedAtoms }: # resolvedAtoms comes from assets/tokens/default.nix

{
  # This function expects the *name* of a palette (e.g., "srcl")
  # and applies the color-roles mapping to that palette.
  mapToSemanticColors = paletteName:
    let
      # Ensure the paletteName is valid before trying to access it
      palette = resolvedAtoms.palettes."${paletteName}" or (throw "Unknown palette: ${paletteName}");
    in
    import ./color-roles.nix { selectedPalette = palette; };
}

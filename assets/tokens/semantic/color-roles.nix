# assets/tokens/semantic/color-roles.nix

{ selectedPalette }: # Takes a resolved palette, e.g., allAtomicTokens.palettes.srcl

{
  pageBackground = selectedPalette.background;
  textPrimary = selectedPalette.foreground;
  textSecondary = selectedPalette.foregroundDim;
  accentPrimary = selectedPalette.accent;
  borderDefault = selectedPalette.border;
  selectionBackground = selectedPalette.selectionBg;
  selectionForeground = selectedPalette.selectionFg;
  terminal = selectedPalette;
}

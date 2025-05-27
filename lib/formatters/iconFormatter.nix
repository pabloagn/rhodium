{ lib, ... }:

{
  # Get icon without formatting
  getIcon = iconPath: fallback:
    let
      char = iconPath.char or fallback;
    in
    "${char}";

  # Format icon with trailing space for starship/terminal use
  formatIcon = iconPath: fallback:
    let
      char = iconPath.char or fallback;
    in
    "${char} ";
}

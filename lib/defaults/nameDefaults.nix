# lib/defaults/nameDefaults.nix

{ lib, ... }:

with lib;
let
  # System name
  systemPrettyName = "Rhodium";

  systemName = {
    pretty = systemPrettyName;
    possessive = "${systemPrettyName}'s";
    lower = toLower systemPrettyName;
    upper = toUpper systemPrettyName;
  };

  workspaceName = systemName.lower;

  dictionaryName = "dictionary";
in
{
  inherit systemName workspaceName dictionaryName;
}

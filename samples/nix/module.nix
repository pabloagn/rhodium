# rhodium.nix
# This is a test for Nix language syntax and formatting.
let
  pkgs = import <nixpkgs> {};
  message = "Welcome to Rhodium";
in
  pkgs.stdenv.mkDerivation {
    pname = "rhodium-test";
    version = "1.0";

    # This is a dummy derivation just for testing Nix syntax.
    # It does not actually build anything useful.
    src = null;
    buildPhase = ''
      echo "${message}" > $out/message.txt
    '';
  }

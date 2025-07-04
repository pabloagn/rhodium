final: prev: {
  custom-fonts = prev.stdenv.mkDerivation rec {
    pname = "rhodium-fonts";
    version = "1.0";
    src = ../assets/fonts;
    installPhase = ''
      mkdir -p $out/share/fonts/{opentype,truetype}
      cp -v *.otf $out/share/fonts/opentype/ 2>/dev/null || true
      cp -v *.ttf $out/share/fonts/truetype/ 2>/dev/null || true
    '';
  };
}

final: prev: {
  rhodium-fonts = prev.stdenv.mkDerivation rec {
    pname = "rhodium-fonts";
    version = "1.0";
    src = ../assets/fonts;
    installPhase = ''
      mkdir -p $out/share/fonts/{opentype,truetype}
      find . -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
      find . -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
    '';
  };
}

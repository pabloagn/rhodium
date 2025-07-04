final: prev: {
  rhodium-fonts = prev.stdenv.mkDerivation rec {
    pname = "rhodium-fonts";
    version = "1.0";
    src = ../assets/fonts;
    
    nativeBuildInputs = with prev; [
      python3
      fontforge
    ];

    nerd-fonts-src = prev.fetchFromGitHub {
      owner = "ryanoasis";
      repo = "nerd-fonts";
      rev = "v3.1.1";
      sha256 = "1dl8xj3w0d2risww8smw8j1w7mq3iy6p1csq00s8iwx15b9phpiz";
    };

    buildPhase = ''
      runHook preBuild

      cp -r ${nerd-fonts-src} nerd-fonts
      chmod -R +w nerd-fonts
      
      mkdir -p patched
      
      if [ -d "BerkeleyMono" ] && [ -n "$(find BerkeleyMono -name '*.otf' -o -name '*.ttf')" ]; then
        echo "Found Berkeley Mono fonts, patching..."
        
        for font in BerkeleyMono/*.otf BerkeleyMono/*.ttf; do
          if [ -f "$font" ]; then
            echo "Patching $font..."
            python3 nerd-fonts/font-patcher \
              "$font" \
              --complete \
              --careful \
              --progressbars \
              --outputdir patched \
              --makegroups 4 \
              --mono \
              --adjust-line-height
            
            if [ $? -ne 0 ]; then
              echo "ERROR: Failed to patch $font"
              exit 1
            fi
          fi
        done
      else
        echo "No Berkeley Mono fonts found to patch"
      fi

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/fonts/{opentype,truetype}
      
      find . -name "*.otf" -not -path "./patched/*" -not -path "./nerd-fonts/*" \
        -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
      find . -name "*.ttf" -not -path "./patched/*" -not -path "./nerd-fonts/*" \
        -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
      
      if [ -d "patched" ] && [ -n "$(find patched -name '*.otf' -o -name '*.ttf')" ]; then
        echo "Installing patched fonts..."
        find patched -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
        find patched -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
      fi

      runHook postInstall
    '';

    meta = with prev.lib; {
      description = "Rhodium fonts including Nerd Fonts patched Berkeley Mono";
      platforms = platforms.all;
    };
  };
}

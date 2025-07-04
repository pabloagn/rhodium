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
      
      mkdir -p patched-mono patched-nonprop
      
      # NOTE: BerkeleyMono .otf does not patch well. Using .ttf
      if [ -d "BerkeleyMono" ] && [ -n "$(find BerkeleyMono -name '*.ttf')" ]; then
        echo "Found Berkeley Mono fonts, patching..."
        
        for font in BerkeleyMono/*.otf BerkeleyMono/*.ttf; do
          if [ -f "$font" ]; then
            basename_font=$(basename "$font")
            echo "Patching $font..."
            
            # --- Generate Monospace Variant (with -s Flag) ---
            echo "Creating monospace variant..."
            python3 nerd-fonts/font-patcher \
              "$font" \
              --complete \
              --careful \
              --progressbars \
              --outputdir patched-mono \
              --makegroups 4 \
              -s \
              --adjust-line-height
            
            if [ $? -ne 0 ]; then
              echo "ERROR: Failed to patch $font (monospace variant)"
              exit 1
            fi
            
            # --- Generate Non-monospace Variant (without -s Flag) ---
            echo "Creating non-monospace variant..."
            python3 nerd-fonts/font-patcher \
              "$font" \
              --complete \
              --careful \
              --progressbars \
              --outputdir patched-nonprop \
              --makegroups 4 \
              --adjust-line-height
            
            if [ $? -ne 0 ]; then
              echo "ERROR: Failed to patch $font (non-monospace variant)"
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
      
      # Install original fonts
      find . -name "*.otf" -not -path "./patched-*/*" -not -path "./nerd-fonts/*" \
        -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
      find . -name "*.ttf" -not -path "./patched-*/*" -not -path "./nerd-fonts/*" \
        -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
      
      # Install monospace patched fonts
      if [ -d "patched-mono" ] && [ -n "$(find patched-mono -name '*.otf' -o -name '*.ttf')" ]; then
        echo "Installing monospace patched fonts..."
        find patched-mono -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
        find patched-mono -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
      fi
      
      # Install non-monospace patched fonts  
      if [ -d "patched-nonprop" ] && [ -n "$(find patched-nonprop -name '*.otf' -o -name '*.ttf')" ]; then
        echo "Installing non-monospace patched fonts..."
        find patched-nonprop -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
        find patched-nonprop -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
      fi
      runHook postInstall
    '';
    
    meta = with prev.lib; {
      description = "Rhodium fonts including both monospace and non-monospace Nerd Fonts patched Berkeley Mono";
      platforms = platforms.all;
    };
  };
}

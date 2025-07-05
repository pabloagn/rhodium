{inputs}: final: prev: {
  rhodium-fonts = prev.stdenv.mkDerivation rec {
    pname = "rhodium-fonts";
    version = "1.0";

    fontSources = {
      berkeley = {
        source = inputs.iridium-rh.packages.${prev.system}.berkeley-mono;
        fonts = {
          # "BerkeleyMonoRh-Black-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Black.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Bold-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Bold.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Book-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Book.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-ExtraBold-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-ExtraBold.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-ExtraLight-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-ExtraLight.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Light-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Light.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Medium-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Medium.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          # "BerkeleyMonoRh-Oblique.ttf" = {
          #   patch = true;
          #   mono = false;
          #   nonprop = true;
          # };
          "BerkeleyMonoRh-Regular.ttf" = {
            patch = true;
            mono = false;
            nonprop = true;
          };
        #   "BerkeleyMonoRh-Retina-Oblique.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-Retina.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-SemiBold-Oblique.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-SemiBold.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-SemiLight-Oblique.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-SemiLight.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-Thin-Oblique.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        #   "BerkeleyMonoRh-Thin.ttf" = {
        #     patch = true;
        #     mono = false;
        #     nonprop = true;
        #   };
        };
      };
      # server = {
      #   source = inputs.iridium-rh.packages.${prev.system}.server-mono;
      #   fonts = {
      #     "ServerMono-Regular.otf" = {
      #       patch = false;
      #       mono = false;
      #       nonprop = false;
      #     };
      #   };
      # };
    };

    dontUnpack = true;

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

      # Process all font sources
      ${prev.lib.concatStringsSep "\n" (prev.lib.mapAttrsToList (familyName: familyConfig: ''
          echo "Processing ${familyName} fonts..."
          mkdir -p ${familyName}

          # Copy fonts from source
          ${prev.lib.concatStringsSep "\n" (prev.lib.mapAttrsToList (fontFile: fontConfig: ''
              cp "${familyConfig.source}/${fontFile}" "${familyName}/${fontFile}" || true
            '')
            familyConfig.fonts)}

          # Patch fonts that need patching
          ${prev.lib.concatStringsSep "\n" (prev.lib.mapAttrsToList (
              fontFile: fontConfig:
                prev.lib.optionalString fontConfig.patch ''
                  if [ -f "${familyName}/${fontFile}" ]; then
                    echo "Patching ${fontFile}..."

                    ${prev.lib.optionalString fontConfig.mono ''
                    python3 nerd-fonts/font-patcher \
                      "${familyName}/${fontFile}" \
                      --complete \
                      --careful \
                      --progressbars \
                      --outputdir patched-mono \
                      --makegroups 4
                      -s \
                      --adjust-line-height || exit 1
                  ''}

                    ${prev.lib.optionalString fontConfig.nonprop ''
                    python3 nerd-fonts/font-patcher \
                      "${familyName}/${fontFile}" \
                      --complete \
                      --careful \
                      --progressbars \
                      --outputdir patched-nonprop \
                      --makegroups 4 \
                      --adjust-line-height || exit 1
                  ''}
                  fi
                ''
            )
            familyConfig.fonts)}
        '')
        fontSources)}

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

      # Install patched fonts
      for dir in patched-mono patched-nonprop; do
        if [ -d "$dir" ]; then
          find "$dir" -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/{} \;
          find "$dir" -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/{} \;
        fi
      done

      runHook postInstall
    '';

    meta = with prev.lib; {
      description = "Rhodium fonts with selective Nerd Fonts patching";
      platforms = platforms.all;
    };
  };
}

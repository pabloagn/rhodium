self: super: {
  rhodium-nerd-font = super.stdenv.mkDerivation rec {
    pname = "rhodium-nerd-font";
    version = super.jetbrains-mono.version;

    src = super.runCommand "rhodium-nerd-font-src" {
      nativeBuildInputs = [ super.unzip ];
    } ''
      mkdir -p $out
      unzip -d $out ${super.jetbrains-mono.src}
      cp ${../assets/icons/F500.svg} $out/F500.svg
    '';

    nativeBuildInputs = [ super.nerd-font-patcher ];

    buildPhase = ''
      runHook preBuild

      mkdir -p custom-icons
      cp F500.svg ./custom-icons/F500.svg

      nerd-font-patcher "JetBrains Mono Regular.ttf" \
        --custom ./custom-icons \
        --fontname "Rhodium Nerd Font" \
        --complete \
        --careful

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      install -D -m444 "Rhodium Nerd Font Regular.ttf" "$out/share/fonts/truetype/Rhodium Nerd Font Regular.ttf"

      runHook postInstall
    '';

    meta = with super.lib; {
      description = "JetBrains Mono patched with a custom Rhodium icon";
      homepage = "https://github.com/pabloagn/rhodium";
      license = licenses.ofl;
      platforms = platforms.all;
    };
  };
}

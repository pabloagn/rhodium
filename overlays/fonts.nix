self: super: {
  rhodium-nerd-font = super.stdenv.mkDerivation rec {
    pname = "rhodium-nerd-font"; # Package name
    version = super.jetbrains-mono.version; # Use the same version as the source font

    # The sources are the original JetBrains Mono font and our custom icon
    srcs = [
      super.jetbrains-mono.src
      ../assets/icons/F500.svg # Path to our icon relative to this file
    ];

    # We need the nerd-font-patcher and unzip to build
    nativeBuildInputs = [super.nerd-font-patcher super.unzip];

    # The source files are read-only, so we need to copy them to a writable location
    sourceRoot = ".";

    buildPhase = ''
      runHook preBuild

      # The patcher needs a specific directory structure for custom icons
      mkdir -p custom-icons
      cp ${./../../assets/icons/F500.svg} ./custom-icons/F500.svg

      # Unzip the source font files
      unzip ${super.jetbrains-mono.src}

      # Run the patcher on the desired font files.
      # We target the regular weight here, but you can add more.
      # The '--fontname' flag is important to avoid name collisions.
      nerd-font-patcher "JetBrains Mono Regular.ttf" \
        --custom ./custom-icons \
        --fontname "Rhodium Nerd Font" \
        --complete \
        --careful

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      # Install the newly created font file into the output directory
      install -D -m444 "Rhodium Nerd Font Regular.ttf" "$out/share/fonts/truetype/Rhodium Nerd Font Regular.ttf"

      runHook postInstall
    '';

    meta = with super.lib; {
      description = "JetBrains Mono patched with a custom Rhodium icon";
      homepage = "https://github.com/pabloagn/rhodium"; # Your repo
      license = licenses.ofl; # Same as JetBrains Mono
      platforms = platforms.all;
    };
  };
}

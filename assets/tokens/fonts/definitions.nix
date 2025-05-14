# assets/tokens/fonts/definitions.nix

{ pkgs, lib }:

{
  # -------------------------------------
  # Nixpkgs Fonts
  # -------------------------------------

  # Monospace
  # -------------------------------------
  JetBrainsMono = {
    fontconfigName = "JetBrains Mono";
    nixPackage = pkgs.jetbrains-mono;
  };

  FiraCode = {
    fontconfigName = "Fira Code";
    nixPackage = pkgs.fira-code;
  };

  FiraCodeSymbols = {
    fontconfigName = "Fira Code Symbols";
    nixPackage = pkgs.fira-code-symbols;
  };

  HackFont = {
    fontconfigName = "Hack";
    nixPackage = pkgs.hack-font;
  };

  IBMPlexMono = {
    fontconfigName = "IBM Plex Mono";
    nixPackage = pkgs.ibm-plex;
  };

  RobotoMono = {
    fontconfigName = "Roboto Mono";
    nixPackage = pkgs.roboto-mono;
  };

  OfficeCodePro = {
    fontconfigName = "Office Code Pro";
    nixPackage = pkgs.office-code-pro;
  };

  Inconsolata = {
    fontconfigName = "Inconsolata";
    nixPackage = pkgs.inconsolata;
  };

  CascadiaCode = {
    fontconfigName = "Cascadia Code";
    nixPackage = pkgs.cascadia-code;
  };

  ParatypePTMono = {
    fontconfigName = "PT Mono";
    nixPackage = pkgs.paratype-pt-mono;
  };

  # Monospace Premium
  # -------------------------------------

  # CommitMono = {
  #   fontconfigName = "CommitMono Nerd Font";
  #   nixPackage = pkgs.nerdfonts.override { fonts = [ "CommitMono" ]; };
  # };

  CommitMono = {
    fontconfigName = "Commit Mono";
    nixPackage = pkgs.commit-mono;
  };

  FragmentMono = {
    fontconfigName = "Fragment Mono";
    nixPackage = pkgs.fragment-mono;
  };

  DepartureMono = {
    fontconfigName = "Departure Mono";
    nixPackage = pkgs.departure-mono;
  };

  Iosevka = {
    fontconfigName = "Iosevka";
    nixPackage = pkgs.iosevka;
  };

  JuliaMono = {
    fontconfigName = "JuliaMono";
    nixPackage = pkgs.juliamono;
  };

  # Sans Serif
  # -------------------------------------
  Inter = {
    fontconfigName = "Inter";
    nixPackage = pkgs.inter;
  };

  LiberationSans = {
    # From liberation_ttf package, targeting Sans variant
    fontconfigName = "Liberation Sans";
    nixPackage = pkgs.liberation_ttf;
  };

  NotoSans = {
    # From noto-fonts package, targeting Sans variant
    fontconfigName = "Noto Sans";
    nixPackage = pkgs.noto-fonts;
  };

  NotoSansCJK = {
    fontconfigName = "Noto Sans CJK";
    nixPackage = pkgs.noto-fonts-cjk-sans;
  };

  NotoFontsEmoji = {
    fontconfigName = "Noto Color Emoji";
    nixPackage = pkgs.noto-fonts-emoji;
  };

  WorkSans = {
    fontconfigName = "Work Sans";
    nixPackage = pkgs.work-sans;
  };

  Roboto = {
    fontconfigName = "Roboto";
    nixPackage = pkgs.roboto;
  };

  Raleway = {
    fontconfigName = "Raleway";
    nixPackage = pkgs.raleway;
  };

  Quicksand = {
    fontconfigName = "Quicksand";
    nixPackage = pkgs.quicksand;
  };

  Lato = {
    fontconfigName = "Lato";
    nixPackage = pkgs.lato;
  };

  Dosis = {
    fontconfigName = "Dosis";
    nixPackage = pkgs.dosis;
  };

  OpenSans = {
    fontconfigName = "Open Sans";
    nixPackage = pkgs.open-sans;
  };

  Montserrat = {
    fontconfigName = "Montserrat";
    nixPackage = pkgs.montserrat;
  };

  SourceSansPro = {
    fontconfigName = "Source Sans Pro";
    nixPackage = pkgs.source-sans-pro;
  };

  LibreFranklin = {
    fontconfigName = "Libre Franklin";
    nixPackage = pkgs.libre-franklin;
  };

  # Serif
  # -------------------------------------
  Cardo = {
    fontconfigName = "Cardo";
    nixPackage = pkgs.cardo;
  };

  Lora = {
    fontconfigName = "Lora";
    nixPackage = pkgs.lora;
  };

  Merriweather = {
    fontconfigName = "Merriweather";
    nixPackage = pkgs.merriweather;
  };

  GaramondLibre = {
    fontconfigName = "Garamond Libre";
    nixPackage = pkgs.garamond-libre;
  };

  CrimsonText = {
    # pkgs.crimson provides Crimson Text
    fontconfigName = "Crimson Text";
    nixPackage = pkgs.crimson;
  };

  CrimsonPro = {
    fontconfigName = "Crimson Pro";
    nixPackage = pkgs.crimson-pro;
  };

  Gelasio = {
    fontconfigName = "Gelasio";
    nixPackage = pkgs.gelasio;
  };

  # Symbols
  # -------------------------------------
  FontAwesome = {
    # Gets latest release
    fontconfigName = "Font Awesome";
    nixPackage = pkgs.font-awesome;
  };

  PowerlineFonts = {
     # Represents the full powerline fonts collection
    fontconfigName = "Powerline Fonts";
    nixPackage = pkgs.powerline-fonts;
  };

  PowerlineSymbols = {
    fontconfigName = "Powerline Symbols";
    nixPackage = pkgs.powerline-symbols;
  };

  NerdFontsCollection = {
    # Represents the full nerdfonts collection
    fontconfigName = "Nerd Fonts";
    nixPackage = pkgs.nerdfonts;
  };

  # -------------------------------------
  # Custom Fonts
  # -------------------------------------
  ServerMono = {
    fontconfigName = "Server Mono";
    nixPackage = pkgs.ServerMono;
  };

  RecursiveMono = {
    fontconfigName = "Recursive Mono";
    nixPackage = pkgs.RecursiveMono;
  };

  TX02BerkeleyMono = {
    fontconfigName = "TX-02 Berkeley Mono";
    nixPackage = pkgs.TX02BerkeleyMono;
  };

  GeistMono = {
    fontconfigName = "Geist Mono";
    nixPackage = pkgs.GeistMono;
  };

  OperatorMono = {
    fontconfigName = "Operator Mono";
    nixPackage = pkgs.OperatorMono;
  };

  PragmataPro = {
    fontconfigName = "PragmataPro";
    nixPackage = pkgs.PragmataPro;
  };

  IngramMono = {
    fontconfigName = "Ingram Mono";
    nixPackage = pkgs.IngramMono;
  };

  DankMono = {
    fontconfigName = "Dank Mono";
    nixPackage = pkgs.DankMono;
  };

  Monolisa = {
    fontconfigName = "Monolisa";
    nixPackage = pkgs.Monolisa;
  };

  CartographCF = {
    fontconfigName = "Cartograph CF";
    nixPackage = pkgs.CartographCF;
  };

  CovikSansMono = {
    fontconfigName = "Covik Sans Mono";
    nixPackage = pkgs.CovikSansMono;
  };

  SFMonoSquare = {
    fontconfigName = "SF Mono Square";
    nixPackage = pkgs.SFMonoSquare;
  };

  KnifMono = {
    fontconfigName = "Knif Mono";
    nixPackage = pkgs.KnifMono;
  };

}

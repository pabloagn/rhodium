{ pkgs, ... }:

{
  monospace = {
    anonymous-pro = {
      package = pkgs.anonymousPro;
      name = "Anonymous Pro";
      style = "Monospace";
    };
    cascadia-code = {
      package = pkgs.cascadia-code;
      name = "Cascadia Code";
      style = "Monospace";
    };
    dejavu-sans-mono = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Mono";
      style = "Monospace";
    };
    fantasque-sans-mono = {
      package = pkgs.fantasque-sans-mono;
      name = "Fantasque Sans Mono";
      style = "Monospace";
    };
    fira-code = {
      package = pkgs.fira-code;
      name = "Fira Code";
      style = "Monospace";
    };
    fira-code-symbols = {
      package = pkgs.fira-code-symbols;
      name = "Fira Code Symbols";
      style = "Symbols";
    };
    hack-font = {
      package = pkgs.hack-font;
      name = "Hack";
      style = "Monospace";
    };
    ibm-plex-mono = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Mono";
      style = "Monospace";
    };
    inconsolata = {
      package = pkgs.inconsolata;
      name = "Inconsolata";
      style = "Monospace";
    };
    jetbrains-mono = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
      style = "Monospace";
    };
    julia-mono = {
      package = pkgs.juliamono;
      name = "JuliaMono";
      style = "Monospace";
    };
    office-code-pro = {
      package = pkgs.office-code-pro;
      name = "Office Code Pro";
      style = "Monospace";
    };
    paratype-pt-mono = {
      package = pkgs.paratype-pt-sans;
      name = "PT Mono";
      style = "Monospace";
    };
    roboto-mono = {
      package = pkgs.roboto-mono;
      name = "Roboto Mono";
      style = "Monospace";
    };
    source-code-pro = {
      package = pkgs.source-code-pro;
      name = "Source Code Pro";
      style = "Monospace";
    };
    ubuntu-mono = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu Mono";
      style = "Monospace";
    };
    victor-mono = {
      package = pkgs.victor-mono;
      name = "Victor Mono";
      style = "Monospace";
    };
  };

  monospace-pro = {
    berkeley-mono = {
      package = null;
      name = "Berkeley Mono";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    cartograph-cf-mono = {
      package = null;
      name = "Cartograph Mono CF";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    commit-mono = {
      package = pkgs.commit-mono;
      name = "CommitMono";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    dank-mono = {
      package = null;
      name = "Dank Mono";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    geist-mono = {
      package = pkgs.geist-font.mono;
      name = "Geist Mono";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    input-mono = {
      package = null;
      name = "Input Mono";
      style = "Monospace Pro";
      licenseInfo = "Free for Personal Use (Custom License)";
    };
    iosevka-pro = {
      package = pkgs.iosevka;
      name = "Iosevka";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    monaspace = {
      package = pkgs.monaspace;
      name = "Monaspace";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    monolisa = {
      package = null;
      name = "MonoLisa";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    operator-mono = {
      package = null;
      name = "Operator Mono";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    pragmatapro = {
      package = null;
      name = "PragmataPro";
      style = "Monospace Pro";
      licenseInfo = "Paid (Commercial)";
    };
    recursive = {
      package = pkgs.recursive;
      name = "Recursive";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    server-mono = {
      package = null; # TODO: Add our own package
      name = "Server Mono";
      style = "Monospace Pro";
      licenseInfo = "Free (SIL OFL)";
    };
    sf-mono = {
      package = null;
      name = "SF Mono";
      style = "Monospace Pro";
      licenseInfo = "Apple (Restrictive)";
    };
  };

  sans-serif = {
    atkinson-hyperlegible = {
      package = pkgs.atkinson-hyperlegible;
      name = "Atkinson Hyperlegible";
      style = "Sans-serif";
    };
    avenir = {
      package = null;
      name = "Avenir";
      style = "Sans-serif";
      licenseInfo = "Paid (Commercial)";
    };
    cabin = {
      package = pkgs.cabin;
      name = "Cabin";
      style = "Sans-serif";
    };
    dosis = {
      package = pkgs.dosis;
      name = "Dosis";
      style = "Sans-serif";
    };
    fira-sans = {
      package = pkgs.fira;
      name = "Fira Sans";
      style = "Sans-serif";
    };
    futura = {
      package = null;
      name = "Futura";
      style = "Sans-serif";
      licenseInfo = "Paid (Commercial)";
    };
    geist-sans = {
      package = pkgs.geist-font.sans;
      name = "Geist Sans";
      style = "Sans-serif";
    };
    helvetica-neue = {
      package = null;
      name = "Helvetica Neue";
      style = "Sans-serif";
      licenseInfo = "Paid (Commercial)";
    };
    inter = {
      package = pkgs.inter;
      name = "Inter";
      style = "Sans-serif";
    };
    lato = {
      package = pkgs.lato;
      name = "Lato";
      style = "Sans-serif";
    };
    liberation-ttf = {
      package = pkgs.liberation_ttf;
      name = "Liberation";
      style = "Sans-serif";
    };
    montserrat = {
      package = pkgs.montserrat;
      name = "Montserrat";
      style = "Sans-serif";
    };
    noto-fonts = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
      style = "Sans-serif";
    };
    noto-fonts-cjk-sans = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK";
      style = "Sans-serif";
    };
    noto-fonts-emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Emoji";
      style = "Sans-serif";
    };
    nunito = {
      package = pkgs.nunito;
      name = "Nunito";
      style = "Sans-serif";
    };
    open-sans = {
      package = pkgs.open-sans;
      name = "Open Sans";
      style = "Sans-serif";
    };
    overpass = {
      package = pkgs.overpass;
      name = "Overpass";
      style = "Sans-serif";
    };
    poppins = {
      package = pkgs.poppins;
      name = "Poppins";
      style = "Sans-serif";
    };
    proxima-nova = {
      package = null;
      name = "Proxima Nova";
      style = "Sans-serif";
      licenseInfo = "Paid (Commercial)";
    };
    quicksand = {
      package = pkgs.quicksand;
      name = "Quicksand";
      style = "Sans-serif";
    };
    raleway = {
      package = pkgs.raleway;
      name = "Raleway";
      style = "Sans-serif";
    };
    roboto = {
      package = pkgs.roboto;
      name = "Roboto";
      style = "Sans-serif";
    };
    source-sans-pro = {
      package = pkgs.source-sans-pro;
      name = "Source Sans Pro";
      style = "Sans-serif";
    };
    ubuntu = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu";
      style = "Sans-serif";
    };
    work-sans = {
      package = pkgs.work-sans;
      name = "Work Sans";
      style = "Sans-serif";
    };
  };

  serif = {
    alegreya = {
      package = pkgs.alegreya;
      name = "Alegreya";
      style = "Serif";
    };
    cardo = {
      package = pkgs.cardo;
      name = "Cardo";
      style = "Serif";
    };
    caslon = {
      package = null;
      name = "Adobe Caslon Pro";
      style = "Serif";
      licenseInfo = "Paid (Adobe)";
    };
    cormorant-garamond = {
      package = pkgs.cormorant-garamond;
      name = "Cormorant Garamond";
      style = "Serif";
    };
    crimson = {
      package = pkgs.crimson;
      name = "Crimson";
      style = "Serif";
    };
    eb-garamond = {
      package = pkgs.eb-garamond;
      name = "EB Garamond";
      style = "Serif";
    };
    garamond-libre = {
      package = pkgs.garamond-libre;
      name = "Garamond Libre";
      style = "Serif";
    };
    gelasio = {
      package = pkgs.gelasio;
      name = "Gelasio";
      style = "Serif";
    };
    liberation-serif = {
      package = pkgs.liberation_serif;
      name = "Liberation Serif";
      style = "Serif";
    };
    libre-baskerville = {
      package = pkgs.libre-baskerville;
      name = "Libre Baskerville";
      style = "Serif";
    };
    lora = {
      package = pkgs.lora;
      name = "Lora";
      style = "Serif";
    };
    merriweather = {
      package = pkgs.merriweather;
      name = "Merriweather";
      style = "Serif";
    };
    minion-pro = {
      package = null;
      name = "Minion Pro";
      style = "Serif";
      licenseInfo = "Paid (Adobe)";
    };
    playfair-display = {
      package = pkgs.playfair-display;
      name = "Playfair Display";
      style = "Serif";
    };
    sabon = {
      package = null;
      name = "Sabon";
      style = "Serif";
      licenseInfo = "Paid (Commercial)";
    };
    source-serif-pro = {
      package = pkgs.source-serif-pro;
      name = "Source Serif Pro";
      style = "Serif";
    };
    vollkorn = {
      package = pkgs.vollkorn;
      name = "Vollkorn";
      style = "Serif";
    };
  };

  display = {
    amatic-sc = {
      package = pkgs.amatic-sc;
      name = "Amatic SC";
      style = "Display";
    };
    anton = {
      package = pkgs.anton;
      name = "Anton";
      style = "Display";
    };
    bangers = {
      package = pkgs.bangers;
      name = "Bangers";
      style = "Display";
    };
    bebas-neue = {
      package = pkgs.bebas-neue;
      name = "Bebas Neue";
      style = "Display";
    };
    comfortaa = {
      package = pkgs.comfortaa;
      name = "Comfortaa";
      style = "Display";
    };
    dancing-script = {
      package = pkgs.dancing-script;
      name = "Dancing Script";
      style = "Display";
    };
    fredoka-one = {
      package = pkgs.fredoka-one;
      name = "Fredoka One";
      style = "Display";
    };
    oswald = {
      package = pkgs.oswald;
      name = "Oswald";
      style = "Display";
    };
    pacifico = {
      package = pkgs.pacifico;
      name = "Pacifico";
      style = "Display";
    };
    righteous = {
      package = pkgs.righteous;
      name = "Righteous";
      style = "Display";
    };
  };

  symbols = {
    feather = {
      package = pkgs.feather-font;
      name = "Feather";
      style = "Symbols";
    };
    font-awesome = {
      package = pkgs.font-awesome;
      name = "Font Awesome";
      style = "Symbols";
    };
    material-design-icons = {
      package = pkgs.material-design-icons;
      name = "Material Design Icons";
      style = "Symbols";
    };
    nerdfonts = {
      package = pkgs.nerdfonts;
      name = "Nerd Fonts";
      style = "Symbols";
    };
    powerline-fonts = {
      package = pkgs.powerline-fonts;
      name = "Powerline Fonts";
      style = "Symbols";
    };
    powerline-symbols = {
      package = pkgs.powerline-symbols;
      name = "Powerline Symbols";
      style = "Symbols";
    };
  };
}


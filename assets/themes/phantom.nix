# assets/themes/phantom.nix

{ lib }:

{
  # Theme metadata
  name = "phantom";
  displayName = "Phantom";
  description = "A dark, modern theme with blue-slate tones and amber accents";
  type = "dark";
  version = "1.0.0";

  # Semantic color mappings
  # These map semantic meanings to specific colors from the palette
  colors = {
    # === TEXT COLORS ===
    text = {
      primary = "slate.100";      # Main text color
      secondary = "slate.300";    # Secondary text
      muted = "slate.500";        # Muted/disabled text
      inverse = "slate.900";      # Text on light backgrounds
      accent = "amber.400";       # Accent text color
      link = "aquamarine.400";    # Links
      code = "cream.200";         # Inline code text
    };

    # === BACKGROUND COLORS ===
    background = {
      primary = "slate.900";      # Main background
      secondary = "slate.800";    # Secondary background (panels, etc.)
      elevated = "slate.700";     # Elevated elements (modals, dropdowns)
      overlay = "slate.600";      # Overlay backgrounds
      surface = "slate.750";      # Card/surface backgrounds
      code = "slate.900";         # Code block backgrounds
      selection = "slate.600";    # Text selection
    };

    # === BORDER COLORS ===
    border = {
      primary = "slate.600";      # Default borders
      secondary = "slate.700";    # Subtle borders
      focus = "amber.500";        # Focus rings
      active = "aquamarine.500";  # Active/selected borders
      error = "salmon.500";       # Error state borders
      warning = "amber.600";      # Warning state borders
      success = "emerald.500";    # Success state borders
    };

    # === INTERACTIVE ELEMENTS ===
    interactive = {
      primary = {
        default = "amber.500";    # Primary buttons/links
        hover = "amber.400";      # Primary hover state
        active = "amber.600";     # Primary active state
        disabled = "slate.600";   # Disabled state
      };
      secondary = {
        default = "slate.600";    # Secondary buttons
        hover = "slate.500";      # Secondary hover
        active = "slate.700";     # Secondary active
        disabled = "slate.700";   # Secondary disabled
      };
      accent = {
        default = "aquamarine.500";
        hover = "aquamarine.400";
        active = "aquamarine.600";
        disabled = "slate.600";
      };
    };

    # === STATUS COLORS ===
    status = {
      success = "emerald.500";
      warning = "amber.500";
      error = "salmon.500";
      info = "aquamarine.500";
    };

    # === SYNTAX HIGHLIGHTING (for code editors) ===
    syntax = {
      # Language constructs
      keyword = "amber.400";         # Keywords (if, else, function, etc.)
      operator = "slate.300";        # Operators (+, -, =, etc.)
      punctuation = "slate.400";     # Brackets, commas, semicolons

      # Literals
      string = "emerald.400";        # String literals
      number = "salmon.400";         # Numbers
      boolean = "salmon.400";        # true/false
      null = "slate.400";            # null/undefined

      # Identifiers
      variable = "slate.200";        # Variables
      parameter = "slate.300";       # Function parameters
      property = "aquamarine.400";   # Object properties
      attribute = "amber.300";       # HTML/XML attributes

      # Types and definitions
      type = "amber.300";            # Type names
      class = "amber.200";           # Class names
      function = "aquamarine.300";   # Function names
      method = "aquamarine.300";     # Method names

      # Comments and documentation
      comment = "slate.500";         # Comments
      docstring = "slate.400";       # Documentation strings

      # Markup (Markdown, HTML, etc.)
      markup = {
        heading = "amber.300";       # Headings
        bold = "cream.200";          # Bold text
        italic = "cream.300";        # Italic text
        link = "aquamarine.400";     # Links
        code = "emerald.400";        # Inline code
        quote = "slate.400";         # Blockquotes
      };

      # Special
      tag = "salmon.400";            # HTML/XML tags
      regex = "aquamarine.400";      # Regular expressions
      escape = "amber.400";          # Escape sequences
      invalid = "salmon.600";        # Invalid/error
    };

    # === UI SPECIFIC COLORS ===
    ui = {
      # Scrollbars
      scrollbar = {
        track = "slate.800";
        thumb = "slate.600";
        thumbHover = "slate.500";
      };

      # Tooltips
      tooltip = {
        background = "slate.700";
        text = "slate.100";
        border = "slate.600";
      };

      # Notifications
      notification = {
        background = "slate.800";
        border = "slate.600";
      };

      # Progress indicators
      progress = {
        background = "slate.700";
        fill = "amber.500";
      };
    };
  };

  # === TYPOGRAPHY ===
  fonts = {
    mono = {
      family = "JetBrains Mono";
      fallbacks = [ "Fira Code" "SF Mono" "Monaco" "Inconsolata" "Roboto Mono" "monospace" ];
      weights = [ 400 500 600 700 ];
      features = [ "liga" "calt" ]; # Ligatures and contextual alternates
    };
    sans = {
      family = "Inter";
      fallbacks = [ "SF Pro Display" "system-ui" "-apple-system" "BlinkMacSystemFont" "sans-serif" ];
      weights = [ 300 400 500 600 700 ];
    };
    serif = {
      family = "Crimson Text";
      fallbacks = [ "Georgia" "Cambria" "Times New Roman" "serif" ];
      weights = [ 400 600 700 ];
    };
  };

  # === VISUAL PROPERTIES ===
  visual = {
    # Border radius scale
    borderRadius = {
      none = "0px";
      sm = "2px";
      default = "4px";
      md = "6px";
      lg = "8px";
      xl = "12px";
      "2xl" = "16px";
      full = "9999px";
    };

    # Shadow scale
    shadows = {
      sm = "0 1px 2px 0 rgba(0, 0, 0, 0.05)";
      default = "0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)";
      md = "0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)";
      lg = "0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)";
      xl = "0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)";
    };

    # Spacing scale (for consistent margins, padding, etc.)
    spacing = {
      "0" = "0px";
      "1" = "4px";
      "2" = "8px";
      "3" = "12px";
      "4" = "16px";
      "5" = "20px";
      "6" = "24px";
      "8" = "32px";
      "10" = "40px";
      "12" = "48px";
      "16" = "64px";
      "20" = "80px";
      "24" = "96px";
      "32" = "128px";
    };

    # Animation durations
    animation = {
      fast = "150ms";
      normal = "250ms";
      slow = "350ms";
      slower = "500ms";
    };

    # Opacity scale
    opacity = {
      "0" = "0";
      "5" = "0.05";
      "10" = "0.1";
      "20" = "0.2";
      "25" = "0.25";
      "30" = "0.3";
      "40" = "0.4";
      "50" = "0.5";
      "60" = "0.6";
      "70" = "0.7";
      "75" = "0.75";
      "80" = "0.8";
      "90" = "0.9";
      "95" = "0.95";
      "100" = "1";
    };
  };

  # === ICONS ===
  icons = {
    set = "lucide"; # Icon set to use
    size = {
      xs = "12px";
      sm = "16px";
      default = "20px";
      md = "24px";
      lg = "32px";
      xl = "48px";
    };
  };

  # === SOUNDS ===
  sounds = {
    notification = "assets/sounds/phantom/notification.wav";
    success = "assets/sounds/phantom/success.wav";
    error = "assets/sounds/phantom/error.wav";
    click = "assets/sounds/phantom/click.wav";
  };

  # === WALLPAPERS ===
  # Note: Actual paths will be resolved by the wallpaper generator
  wallpapers = {
    primary = 1; # Use wallpaper-01.jpg as primary
    available = lib.range 1 11; # wallpaper-01.jpg through wallpaper-11.jpg
  };
}

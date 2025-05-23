# assets/icons/unicode.nix
# Standard Unicode character definitions for NixOS with code points

{
  unicode = {
    # Arrows
    arrows = {
      right = { char = "→"; code = "U+2192"; };
      left = { char = "←"; code = "U+2190"; };
      up = { char = "↑"; code = "U+2191"; };
      down = { char = "↓"; code = "U+2193"; };
      upRight = { char = "↗"; code = "U+2197"; };
      upLeft = { char = "↖"; code = "U+2196"; };
      downRight = { char = "↘"; code = "U+2198"; };
      downLeft = { char = "↙"; code = "U+2199"; };
      rightDouble = { char = "⇒"; code = "U+21D2"; };
      leftDouble = { char = "⇐"; code = "U+21D0"; };
      upDown = { char = "↕"; code = "U+2195"; };
      leftRight = { char = "↔"; code = "U+2194"; };
      rightThick = { char = "➔"; code = "U+2794"; };
      rightLong = { char = "⟶"; code = "U+27F6"; };
      leftLong = { char = "⟵"; code = "U+27F5"; };
      rightHook = { char = "↪"; code = "U+21AA"; };
      leftHook = { char = "↩"; code = "U+21A9"; };
      rightTail = { char = "⤑"; code = "U+2911"; };
      leftTail = { char = "⬸"; code = "U+2B38"; };
      rightDashed = { char = "⇢"; code = "U+21E2"; };
      leftDashed = { char = "⇠"; code = "U+21E0"; };
    };

    # Math
    math = {
      plus = { char = "+"; code = "U+002B"; };
      minus = { char = "−"; code = "U+2212"; };
      multiply = { char = "×"; code = "U+00D7"; };
      divide = { char = "÷"; code = "U+00F7"; };
      equal = { char = "="; code = "U+003D"; };
      notEqual = { char = "≠"; code = "U+2260"; };
      approx = { char = "≈"; code = "U+2248"; };
      infinity = { char = "∞"; code = "U+221E"; };
      sum = { char = "∑"; code = "U+2211"; };
      product = { char = "∏"; code = "U+220F"; };
      integral = { char = "∫"; code = "U+222B"; };
      doubleIntegral = { char = "∬"; code = "U+222C"; };
      tripleIntegral = { char = "∭"; code = "U+222D"; };
      contourIntegral = { char = "∮"; code = "U+222E"; };
      squareRoot = { char = "√"; code = "U+221A"; };
      cubeRoot = { char = "∛"; code = "U+221B"; };
      fourthRoot = { char = "∜"; code = "U+221C"; };
      plusMinus = { char = "±"; code = "U+00B1"; };
      minusPlus = { char = "∓"; code = "U+2213"; };
      lessThan = { char = "<"; code = "U+003C"; };
      greaterThan = { char = ">"; code = "U+003E"; };
      lessThanEqual = { char = "≤"; code = "U+2264"; };
      greaterThanEqual = { char = "≥"; code = "U+2265"; };
      muchLessThan = { char = "≪"; code = "U+226A"; };
      muchGreaterThan = { char = "≫"; code = "U+226B"; };
      subset = { char = "⊂"; code = "U+2282"; };
      superset = { char = "⊃"; code = "U+2283"; };
      subsetEqual = { char = "⊆"; code = "U+2286"; };
      supersetEqual = { char = "⊇"; code = "U+2287"; };
      intersection = { char = "∩"; code = "U+2229"; };
      union = { char = "∪"; code = "U+222A"; };
      elementOf = { char = "∈"; code = "U+2208"; };
      notElementOf = { char = "∉"; code = "U+2209"; };
      forAll = { char = "∀"; code = "U+2200"; };
      thereExists = { char = "∃"; code = "U+2203"; };
      thereNotExists = { char = "∄"; code = "U+2204"; };
      degree = { char = "°"; code = "U+00B0"; };
      partial = { char = "∂"; code = "U+2202"; };
      gradient = { char = "∇"; code = "U+2207"; };
      proportional = { char = "∝"; code = "U+221D"; };
      infty = { char = "∞"; code = "U+221E"; };
      prime = { char = "′"; code = "U+2032"; };
      doublePrime = { char = "″"; code = "U+2033"; };
      triplePrime = { char = "‴"; code = "U+2034"; };
      empty = { char = "∅"; code = "U+2205"; };
      aplUpCaret = { char = "⎉"; code = "U+2389"; };
      lambda = { char = "λ"; code = "U+03BB"; };
    };

    # Checkboxes and status indicators
    status = {
      check = { char = "✓"; code = "U+2713"; };
      heavyCheck = { char = "✔"; code = "U+2714"; };
      cross = { char = "✗"; code = "U+2717"; };
      heavyCross = { char = "✘"; code = "U+2718"; };
      ballot = { char = "☐"; code = "U+2610"; };
      ballotCheck = { char = "☑"; code = "U+2611"; };
      ballotCross = { char = "☒"; code = "U+2612"; };
      radioEmpty = { char = "○"; code = "U+25CB"; };
      radioFull = { char = "●"; code = "U+25CF"; };
      warning = { char = "⚠"; code = "U+26A0"; };
      info = { char = "ℹ"; code = "U+2139"; };
      question = { char = "?"; code = "U+003F"; };
      exclamation = { char = "!"; code = "U+0021"; };
      questionMark = { char = "❓"; code = "U+2753"; };
      exclamationMark = { char = "❗"; code = "U+2757"; };
      success = { char = "✅"; code = "U+2705"; };
      failure = { char = "❌"; code = "U+274C"; };
    };

    # Weather and nature
    weather = {
      sun = { char = "☀"; code = "U+2600"; };
      cloud = { char = "☁"; code = "U+2601"; };
      umbrella = { char = "☂"; code = "U+2602"; };
      snowflake = { char = "❄"; code = "U+2744"; };
      comet = { char = "☄"; code = "U+2604"; };
      star = { char = "★"; code = "U+2605"; };
      emptyStar = { char = "☆"; code = "U+2606"; };
      flower = { char = "❀"; code = "U+2740"; };
      fourLeafClover = { char = "🍀"; code = "U+1F340"; };
      snowman = { char = "☃"; code = "U+2603"; };
    };

    # Technology and UI
    tech = {
      power = { char = "⏻"; code = "U+23FB"; };
      eject = { char = "⏏"; code = "U+23CF"; };
      keyboard = { char = "⌨"; code = "U+2328"; };
      command = { char = "⌘"; code = "U+2318"; };
      option = { char = "⌥"; code = "U+2325"; };
      delete = { char = "⌫"; code = "U+232B"; };
      return = { char = "⏎"; code = "U+23CE"; };
      escape = { char = "⎋"; code = "U+238B"; };
      play = { char = "▶"; code = "U+25B6"; };
      pause = { char = "⏸"; code = "U+23F8"; };
      stop = { char = "⏹"; code = "U+23F9"; };
      record = { char = "⏺"; code = "U+23FA"; };
      skipForward = { char = "⏭"; code = "U+23ED"; };
      skipBack = { char = "⏮"; code = "U+23EE"; };
      enter = { char = "⌤"; code = "U+2324"; };
      home = { char = "⌂"; code = "U+2302"; };
      shift = { char = "⇧"; code = "U+21E7"; };
      tab = { char = "⇥"; code = "U+21E5"; };
      capsLock = { char = "⇪"; code = "U+21EA"; };
      mute = { char = "🔇"; code = "U+1F507"; };
      volumeDown = { char = "🔉"; code = "U+1F509"; };
      volumeUp = { char = "🔊"; code = "U+1F50A"; };
      settings = { char = "⚙"; code = "U+2699"; };
    };

    # Currency
    currency = {
      dollar = { char = "$"; code = "U+0024"; };
      euro = { char = "€"; code = "U+20AC"; };
      pound = { char = "£"; code = "U+00A3"; };
      yen = { char = "¥"; code = "U+00A5"; };
      bitcoin = { char = "₿"; code = "U+20BF"; };
      cent = { char = "¢"; code = "U+00A2"; };
      currency = { char = "¤"; code = "U+00A4"; };
      rupee = { char = "₹"; code = "U+20B9"; };
      won = { char = "₩"; code = "U+20A9"; };
      franc = { char = "₣"; code = "U+20A3"; };
      lira = { char = "₤"; code = "U+20A4"; };
      peso = { char = "₱"; code = "U+20B1"; };
    };

    # Punctuation and typography
    typography = {
      bullet = { char = "•"; code = "U+2022"; };
      triangleBullet = { char = "‣"; code = "U+2023"; };
      interpunct = { char = "·"; code = "U+00B7"; };
      ellipsis = { char = "…"; code = "U+2026"; };
      quote = { char = "«»"; code = "U+00AB U+00BB"; };
      quoteLeft = { char = "«"; code = "U+00AB"; };
      quoteRight = { char = "»"; code = "U+00BB"; };
      dash = { char = "—"; code = "U+2014"; };
      ndash = { char = "–"; code = "U+2013"; };
      copyright = { char = "©"; code = "U+00A9"; };
      registered = { char = "®"; code = "U+00AE"; };
      trademark = { char = "™"; code = "U+2122"; };
      paragraph = { char = "¶"; code = "U+00B6"; };
      section = { char = "§"; code = "U+00A7"; };
      dagger = { char = "†"; code = "U+2020"; };
      doubleDagger = { char = "‡"; code = "U+2021"; };
    };

    # Brackets and separators
    brackets = {
      leftParenthesis = { char = "("; code = "U+0028"; };
      rightParenthesis = { char = ")"; code = "U+0029"; };
      leftBracket = { char = "["; code = "U+005B"; };
      rightBracket = { char = "]"; code = "U+005D"; };
      leftBrace = { char = "{"; code = "U+007B"; };
      rightBrace = { char = "}"; code = "U+007D"; };
      leftAngle = { char = "⟨"; code = "U+27E8"; };
      rightAngle = { char = "⟩"; code = "U+27E9"; };
      leftDoubleAngle = { char = "《"; code = "U+300A"; };
      rightDoubleAngle = { char = "》"; code = "U+300B"; };
      vertical = { char = "|"; code = "U+007C"; };
      doubleVertical = { char = "‖"; code = "U+2016"; };
      leftChevron = { char = "‹"; code = "U+2039"; };
      rightChevron = { char = "›"; code = "U+203A"; };
      leftGuillemet = { char = "«"; code = "U+00AB"; };
      rightGuillemet = { char = "»"; code = "U+00BB"; };
      dot = { char = "."; code = "U+002E"; };
      verticalLine = { char = "│"; code = "U+2502"; };
      doubleVerticalLine = { char = "║"; code = "U+2551"; };
      topHeader = { char = "╦"; code = "U+2566"; };
      doubleTop = { char = "╤"; code = "U+2564"; };
      topRight = { char = "┐"; code = "U+2510"; };
      topLeft = { char = "┌"; code = "U+250C"; };
      bottomRight = { char = "┘"; code = "U+2518"; };
      bottomLeft = { char = "└"; code = "U+2514"; };
      teeRight = { char = "├"; code = "U+251C"; };
      teeLeft = { char = "┤"; code = "U+2524"; };
      teeUp = { char = "┴"; code = "U+2534"; };
      teeDown = { char = "┬"; code = "U+252C"; };
      cross = { char = "┼"; code = "U+253C"; };
      horizontalLine = { char = "─"; code = "U+2500"; };
      doubleHorizontalLine = { char = "═"; code = "U+2550"; };
    };

    # Loading indicators and progress
    loading = {
      shade1 = { char = "░"; code = "U+2591"; };
      shade2 = { char = "▒"; code = "U+2592"; };
      shade3 = { char = "▓"; code = "U+2593"; };
      block = { char = "█"; code = "U+2588"; };
      leftSevenEighths = { char = "▉"; code = "U+2589"; };
      leftThreeQuarters = { char = "▌"; code = "U+258C"; };
      leftHalf = { char = "▐"; code = "U+258C"; };
      leftQuarter = { char = "▎"; code = "U+258E"; };
      leftEighth = { char = "▏"; code = "U+258F"; };
      spinnerSlash = { char = "⁄"; code = "U+2044"; };
      spinnerBackslash = { char = "\\"; code = "U+005C"; };
      spinnerVertical = { char = "│"; code = "U+2502"; };
      spinnerHorizontal = { char = "─"; code = "U+2500"; };
      spinnerPlus = { char = "+"; code = "U+002B"; };
      spinnerX = { char = "×"; code = "U+00D7"; };
    };

    # React and UI components
    react = {
      collapse = { char = "▼"; code = "U+25BC"; };
      expand = { char = "▶"; code = "U+25B6"; };
      hamburger = { char = "☰"; code = "U+2630"; };
      kebab = { char = "⋮"; code = "U+22EE"; };
      meatball = { char = "⋯"; code = "U+22EF"; };
      refresh = { char = "↻"; code = "U+21BB"; };
      settings = { char = "⚙"; code = "U+2699"; };
      chevronLeft = { char = "❮"; code = "U+276E"; };
      chevronRight = { char = "❯"; code = "U+276F"; };
      chevronUp = { char = "▲"; code = "U+25B2"; };
      chevronDown = { char = "▼"; code = "U+25BC"; };
      caretUp = { char = "▴"; code = "U+25B4"; };
      caretDown = { char = "▾"; code = "U+25BE"; };
      caretLeft = { char = "◂"; code = "U+25C2"; };
      caretRight = { char = "▸"; code = "U+25B8"; };
      singleLeft = { char = "❮"; code = "U+276E"; }; # Duplicate, keeping for original key consistency
      singleRight = { char = "❯"; code = "U+276F"; }; # Duplicate, keeping for original key consistency
      doubleLeft = { char = "«"; code = "U+00AB"; }; # Duplicate, keeping for original key consistency
      doubleRight = { char = "»"; code = "U+00BB"; }; # Duplicate, keeping for original key consistency
      star = { char = "★"; code = "U+2605"; }; # Duplicate, keeping for original key consistency
      emptyStar = { char = "☆"; code = "U+2606"; }; # Duplicate, keeping for original key consistency
      halfStar = { char = "★☆"; code = "U+2605 U+2606"; };
      heart = { char = "♥"; code = "U+2665"; };
      emptyHeart = { char = "♡"; code = "U+2661"; };
      user = { char = "👤"; code = "U+1F464"; };
      search = { char = "🔍"; code = "U+1F50D"; };
      external = { char = "⬀"; code = "U+2B00"; };
      home = { char = "⌂"; code = "U+2302"; }; # Duplicate, keeping for original key consistency
    };

    # Programming Languages (Only standard Unicode symbols relevant to programming)
    programming = {
      nushellArrow = { char = ">"; code = "U+003E"; }; # GREATER-THAN SIGN for nushell
    };

    # File System and Generic File Icons
    files = {}; # No standard Unicode characters added from yazi config here

    # OS and Environment Configurations
    osAndEnvironments = {}; # No standard Unicode characters added from yazi config here

    # Build Tools
    buildTools = {}; # No standard Unicode characters added from yazi config here

    # Source Control
    sourceControl = {}; # No standard Unicode characters added from yazi config here

    # Editors & IDEs
    editors = {}; # No standard Unicode characters added from yazi config here

    # CAD and 3D Modeling
    cadAnd3d = {}; # No standard Unicode characters added from yazi config here

    # Design and Media
    designAndMedia = {}; # No standard Unicode characters added from yazi config here

    # Documents and Ebooks
    documents = {}; # No standard Unicode characters added from yazi config here

    # Web Development and Frontend
    web = {}; # No standard Unicode characters added from yazi config here

    # Security related Icons
    security = {}; # No standard Unicode characters added from yazi config here

    # Miscellaneous Icons
    misc = {}; # No standard Unicode characters added from yazi config here
  };
}

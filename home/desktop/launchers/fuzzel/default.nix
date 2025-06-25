{pkgs, ...}: {
  programs.fuzzel = {
    settings = {
      main = {
        terminal = "ghostty -e";
        layer = "overlay";
        # HACK: We needed to use JuliaMono since it was the font with widest adoption of unicode symbols.
        font = "JuliaMono:size=14, JetBrainsMono Nerd Font:size=14";
        dpi-aware = false;
        prompt = "'λ '";
        icons-enabled = true;
        show-actions = false;
        sort-result = true;
        match-mode = "fuzzy";
        match-counter = true;
        lines = 15;
        width = 60;
        tabs = 8;
        horizontal-pad = 40;
        vertical-pad = 20;
        inner-pad = 20;
        image-size-ratio = 0.5;
        letter-spacing = 0;
        hide-before-typing = false;
        exit-on-keyboard-focus-loss = false;
        keyboard-focus = "on-demand";
      };
      border = {
        width = 1;
        radius = 0;
      };
      colors = {
        background = "#20131eff";
        text = "#feebeeff";
        match = "#8e4057ff";
        selection = "#462941ff";
        selection-text = "#feebeeff";
        border = "#7d3d52ff";
      };
      dmenu = {
        mode = "text";
        exit-immediately-if-empty = false;
      };
    };
  };
}

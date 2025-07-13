{ pkgs, ... }:
{
  programs.fuzzel = {
    settings = {
      border = {
        radius = 0;
        width = 1;
      };
      colors = {
        background = "#20131eff";
        border = "#7d3d52ff";
        match = "#8e4057ff";
        placeholder = "#586e75ff";
        prompt = "#586e75ff";
        selection = "#462941ff";
        selection-match = "#8e4057ff";
        selection-text = "#f2f2f2ff";
        text = "#f2f2f2ff";
      };
      dmenu = {
        exit-immediately-if-empty = false;
        mode = "text";
      };
      main = {
        # HACK:
        # We needed to use a compatible font (BerkeleyMono, JuliaMono)
        # since it was the font with widest adoption of unicode symbols
        dpi-aware = false;
        exit-on-keyboard-focus-loss = false;
        font = "BerkeleyMonoRh Nerd Font:size=14, JuliaMono:size=14, JetBrainsMono Nerd Font:size=14";
        hide-before-typing = false;
        horizontal-pad = 40;
        icons-enabled = true;
        image-size-ratio = 0.5;
        inner-pad = 20;
        keyboard-focus = "exclusive"; # Other option: on-demand
        layer = "overlay";
        letter-spacing = 0;
        lines = 15;
        match-counter = true;
        match-mode = "fuzzy";
        prompt = "'λ '"; # NOTE: Default prompt if none provided
        show-actions = false;
        sort-result = true;
        tabs = 8;
        terminal = "kitty -e";
        use-bold = false;
        vertical-pad = 20;
        width = 60;
      };
    };
  };
}

# home/development/editors/helix/themeConfig.nix

{ config, lib, pkgs, rhodiumLib, ... }:

let
  # Function to generate Helix theme from rhodium theme system
  generateHelixThemeFromRhodium = rhodiumThemeName:
    let
      # Resolve the theme using rhodium's theme system
      resolvedTheme = rhodiumLib.theme.resolveTheme rhodiumThemeName;
      colors = resolvedTheme.colors.hex;
    in {
      # Base theme to inherit from
      "inherits" = "dark_plus";

      # UI Colors
      "ui.background" = colors.background.primary;
      "ui.background.separator" = colors.border.primary;
      "ui.cursor" = colors.interactive.accent.default;
      "ui.cursor.match" = colors.interactive.accent.hover;
      "ui.cursor.primary" = colors.interactive.primary.default;
      "ui.cursor.secondary" = colors.interactive.secondary.default;
      "ui.linenr" = colors.text.muted;
      "ui.linenr.selected" = colors.text.secondary;
      "ui.statusline" = {
        fg = colors.text.primary;
        bg = colors.background.secondary;
      };
      "ui.statusline.inactive" = {
        fg = colors.text.muted;
        bg = colors.background.primary;
      };
      "ui.popup" = colors.background.elevated;
      "ui.window" = colors.border.primary;
      "ui.help" = colors.background.elevated;
      "ui.text" = colors.text.primary;
      "ui.text.focus" = colors.text.primary;
      "ui.selection" = colors.background.selection;
      "ui.selection.primary" = colors.background.selection;
      "ui.cursorline.primary" = colors.background.secondary;
      "ui.cursorline.secondary" = colors.background.secondary;
      "ui.virtual.whitespace" = colors.text.muted;
      "ui.virtual.ruler" = colors.border.secondary;

      # Menu and completion
      "ui.menu" = colors.background.elevated;
      "ui.menu.selected" = colors.background.selection;
      "ui.menu.scroll" = colors.ui.scrollbar.thumb;

      # Syntax highlighting from resolved theme
      "type" = colors.syntax.type;
      "constant" = colors.syntax.number;
      "constant.builtin" = colors.syntax.boolean;
      "constant.builtin.boolean" = colors.syntax.boolean;
      "constant.character.escape" = colors.syntax.escape;
      "string" = colors.syntax.string;
      "string.regexp" = colors.syntax.regex;
      "comment" = colors.syntax.comment;
      "variable" = colors.syntax.variable;
      "variable.builtin" = colors.syntax.keyword;
      "variable.parameter" = colors.syntax.parameter;
      "variable.other.member" = colors.syntax.property;
      "label" = colors.syntax.keyword;
      "punctuation" = colors.syntax.punctuation;
      "punctuation.delimiter" = colors.syntax.punctuation;
      "punctuation.bracket" = colors.syntax.punctuation;
      "keyword" = colors.syntax.keyword;
      "keyword.operator" = colors.syntax.operator;
      "keyword.directive" = colors.syntax.keyword;
      "keyword.function" = colors.syntax.keyword;
      "operator" = colors.syntax.operator;
      "function" = colors.syntax.function;
      "function.builtin" = colors.syntax.function;
      "function.method" = colors.syntax.method;
      "tag" = colors.syntax.tag;
      "namespace" = colors.syntax.class;
      "markup.heading" = colors.syntax.markup.heading;
      "markup.list" = colors.text.primary;
      "markup.bold" = {
        fg = colors.syntax.markup.bold;
        modifiers = ["bold"];
      };
      "markup.italic" = {
        fg = colors.syntax.markup.italic;
        modifiers = ["italic"];
      };
      "markup.link.url" = colors.syntax.markup.link;
      "markup.link.text" = colors.syntax.markup.link;
      "markup.quote" = colors.syntax.markup.quote;
      "markup.raw" = colors.syntax.markup.code;

      # Diagnostics
      "diagnostic" = colors.text.muted;
      "diagnostic.hint" = colors.status.info;
      "diagnostic.info" = colors.status.info;
      "diagnostic.warning" = colors.status.warning;
      "diagnostic.error" = colors.status.error;

      # Diff
      "diff.plus" = colors.status.success;
      "diff.delta" = colors.status.warning;
      "diff.minus" = colors.status.error;
    };

  # Your existing themes, now enhanced with rhodium theme generation
  existingThemes = {
    # Your existing static themes
    tokyonight = {
      # ... your existing theme definition
    };
    # Add more existing themes...
  };

  # Generate rhodium-based themes
  rhodiumThemes = {
    phantom = generateHelixThemeFromRhodium "phantom";
    # ghost = generateHelixThemeFromRhodium "ghost";
    # minimal = generateHelixThemeFromRhodium "minimal";
  };

in {
  # Combine existing themes with rhodium-generated themes
  themes = existingThemes // rhodiumThemes;

  # Variants can also use the rhodium system
  variants = {
    # You can create variants of rhodium themes
    "phantom-light" =
      let
        baseTheme = rhodiumThemes.phantom;
        # Override specific colors for light variant
      in baseTheme // {
        "ui.background" = "#ffffff";
        # ... other light variant overrides
      };
  };
}

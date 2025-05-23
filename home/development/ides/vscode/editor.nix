# home/development/ides/vscode/editor.nix

{
  # Basic editor settings
  "editor.tabSize" = 2;
  "editor.insertSpaces" = true;
  "editor.detectIndentation" = false;
  "editor.suggestSelection" = "first";
  "editor.linkedEditing" = true;
  "editor.suggest.insertMode" = "replace";
  "editor.inlineSuggest.enabled" = true;
  "editor.codeLens" = true;
  "editor.formatOnSave" = false;

  # Font and typography
  "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', 'FiraCode Nerd Font', 'Fira Code', Menlo, Monaco, 'Courier New', monospace";
  "editor.fontLigatures" = true;
  "editor.fontSize" = 14;
  "editor.lineHeight" = 1.6;
  "editor.wordWrap" = "on";

  # Visual guides
  "editor.rulers" = [ 80 120 ];
  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = "active";
  "editor.guides.bracketPairsHorizontal" = true;
  "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;

  # Unicode and special characters
  "editor.unicodeHighlight.ambiguousCharacters" = true;
  "editor.unicodeHighlight.invisibleCharacters" = true;

  # Minimap
  "editor.minimap.enabled" = true;
  "editor.minimap.side" = "right";
  "editor.minimap.scale" = 1;
  "editor.minimap.renderCharacters" = true;
  "editor.minimap.showSlider" = "always";

  # Cursor and animation
  "editor.cursorBlinking" = "smooth";
  "editor.cursorSmoothCaretAnimation" = "on";
  "editor.cursorStyle" = "line";
  "editor.smoothScrolling" = true;

  # Terminal
  "terminal.integrated.cursorBlinking" = true;
  "terminal.integrated.smoothScrolling" = true;
}

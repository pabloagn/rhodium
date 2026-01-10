{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Screenshot And Image Tools ---
    # flameshot # Screenshot utility
    grim # Screenshot utility for Wayland
    gtk3 # Includes gtk-launch
    hyprpicker # Color picker for hyprland
    satty
    slurp # Interactive area selection
    swappy # Screenshot annotation tool
    tesseract # OCR Engine

    # --- Clipboard Utilities ---
    clipman # Clipboard manager for Wayland
    wl-clipboard # Wayland clipboard utilities

    # --- Utils ---
    comma # Runs programs without installing them
    fontforge # For font previews
    ghostscript # Postscript interpreter
    mermaid-cli # Generation of mermaid diagrams in text
    pandoc # PDF manipulation
    poppler-utils # For PDF previews (pdftotext)
    tui-journal # Rust TUI for note-taking

    # --- Documentation ---
    # tldr # Simplified and community-driven man pages
    # tlrc # Official tldr client written in Rust (includes tlrd)
    tealdeer # Alternative fast Rust client
    wikiman # Offline search engine for Linux packages

    # --- Misc ---
    bc # CLI calculator
    binutils # Tools for manipulating binaries
    just # Handy way to save and run project-specific commands
    mask # CLI task runner defined by a simple markdown file
    mprocs # TUI tool to run multiple commands in parallel and show the output of each command separately
    presenterm # Terminal based slideshow tool
    hstr # Shell history suggest box (bound to <C-H> on Shell)
    ispell # Interactive spell checker (used by Doom Emacs)

    # --- Navigation ---
    # wiki-tui # Simple and easy to use Wikipedia Text User Interface
  ];
}

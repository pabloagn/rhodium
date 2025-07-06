{pkgs, ...}: {
  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    # Screenshot and image tools
    slurp # Interactive area selection
    grim # Screenshot utility for Wayland
    swappy # Screenshot annotation tool
    hyprpicker # Color picker for hyprland
    # flameshot # Screenshot utility
    satty

    gtk3 # Includes gtk-launch

    # Clipboard utilities
    wl-clipboard # Wayland clipboard utilities

    # Utils
    mermaid-cli # Generation of mermaid diagrams in text
    pandoc # PDF manipulation
    poppler_utils # For PDF previews (pdftotext)
    fontforge # For font previews
    comma # Runs programs without installing them
    ghostscript # Postscript interpreter

    # Documentation
    # tldr # Simplified and community-driven man pages
    # tlrc # Official tldr client written in Rust (includes tlrd)
    tealdeer # Alternative fast Rust client
    wikiman # Offline search engine for Linux packages

    # Misc
    bc # CLI calculator
    binutils # Tools for manipulating binaries
    just # Handy way to save and run project-specific commands
    mask # CLI task runner defined by a simple markdown file
    mprocs # TUI tool to run multiple commands in parallel and show the output of each command separately
    presenterm # Terminal based slideshow tool
    hstr # Shell history suggest box (bound to <C-H> on Shell)

    # Navigation
    # wiki-tui # Simple and easy to use Wikipedia Text User Interface
  ];
}

{ pkgs, ... }:
{
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

    gtk3 # Includes gtk-launch

    # Clipboard utilities
    wl-clipboard # Wayland clipboard utilities

    pandoc # Needed for Markdown -> HTML conversion (in our script)
    poppler_utils # For PDF previews (pdftotext)
    fontforge # For font previews

    # Documentation
    # tldr # Simplified and community-driven man pages
    tlrc # Official tldr client written in Rust (includes tlrd)

    # Pendings to categorize
    bc # CLI calculator
    binutils # Tools for manipulating binaries
    just # Handy way to save and run project-specific commands
    mask # CLI task runner defined by a simple markdown file
    mprocs # TUI tool to run multiple commands in parallel and show the output of each command separately
    presenterm # Terminal based slideshow tool

    # Navigation
    wiki-tui # Simple and easy to use Wikipedia Text User Interface
  ];
}

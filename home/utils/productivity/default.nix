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

    # Clipboard utilities
    wl-clipboard # Wayland clipboard utilities

    pandoc            # Needed for Markdown -> HTML conversion (in our script)
    poppler_utils     # For PDF previews (pdftotext)
    fontforge         # For font previews

    # Documentation
    # tldr # Simplified and community-driven man pages
    tlrc # Official tldr client written in Rust (includes tlrd)

    # Pendings to categorize
    bc # CLI calculator
    binutils # Tools for manipulating binaries
  ];
}

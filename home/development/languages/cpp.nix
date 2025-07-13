{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- C/c++ ---
    clang-tools # Includes clang-format
    gcc # GNU compiler collection
    gnumake # GNU Make build system
  ];
}

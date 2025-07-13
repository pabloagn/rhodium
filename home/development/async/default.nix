{ pkgs, ... }:
{
  home.packages = with pkgs; [
    expect # Includes unbuffer. Disables the output buffering that occurs when program output is redirected from non-interactive programs
  ];
}

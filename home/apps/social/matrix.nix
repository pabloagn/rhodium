{ pkgs, ... }:
{
  home.packages = with pkgs; [
    element-call
    element-desktop
    gomuks # Matrix TUI client
  ];
}


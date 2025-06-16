{pkgs, ...}: {
  home.packages = with pkgs; [
    standardnotes
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    st
  ];
}

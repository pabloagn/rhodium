{pkgs, ...}: {
  imports = [
  ];

  home.packages = with pkgs; [
    duf # Yet another disk utility
  ];
}


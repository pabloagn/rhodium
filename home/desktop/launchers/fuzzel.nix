{pkgs, ...}: {
  imports = [
    ./fuzzel
  ];

  programs.fuzzel = {
    enable = true;
  };
}

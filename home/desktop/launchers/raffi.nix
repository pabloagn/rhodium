{pkgs, ...}: {
  home.packages = with pkgs; [
    raffi # Raffi config is generated dynamically. Check home modules
  ];
}

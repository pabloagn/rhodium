{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python
    python312Packages.ipykernel
    python313Packages.ipykernel
    python312Packages.wcwidth # Required for unicode menus
    python313Packages.wcwidth
  ];
}

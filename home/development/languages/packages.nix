{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python
    python311Packages.ipykernel
    python312Packages.ipykernel
  ];
}

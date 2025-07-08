{
  pkgs,
  inputs,
  lib,
  ...
}: let
  astalLibs = [
    inputs.astal.packages.${pkgs.system}.astal4
    inputs.astal.packages.${pkgs.system}.io
    inputs.astal.packages.${pkgs.system}.battery
    inputs.astal.packages.${pkgs.system}.network
    inputs.astal.packages.${pkgs.system}.hyprland
  ];
in
  pkgs.mkShell {
    buildInputs =
      astalLibs
      ++ [
        pkgs.gjs
        pkgs.gtk4
        pkgs.glib
        pkgs.esbuild
        pkgs.nodejs
        inputs.ags.packages.${pkgs.system}.default
      ];

    shellHook = ''
      export GI_TYPELIB_PATH=${lib.concatStringsSep ":" (map (p: "${p}/lib/girepository-1.0") astalLibs)}
      export LD_LIBRARY_PATH=${lib.concatStringsSep ":" (map (p: "${p}/lib") astalLibs)}
      echo "Astal dev shell ready. Use 'ags run' or build with 'esbuild'."
    '';
  }

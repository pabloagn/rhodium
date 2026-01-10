{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.battery
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.network
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.bluetooth
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.tray
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.mpris
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.apps
      inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.notifd
      jq
      curl
      fzf
    ];
  };
}

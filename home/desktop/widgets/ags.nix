{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    configDir = ../ags;
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.astal.battery
      inputs.ags.packages.${pkgs.system}.astal.network
      inputs.ags.packages.${pkgs.system}.astal.bluetooth
      inputs.ags.packages.${pkgs.system}.astal.tray
      inputs.ags.packages.${pkgs.system}.astal.mpris
      inputs.ags.packages.${pkgs.system}.astal.apps
      inputs.ags.packages.${pkgs.system}.astal.notifd
      jq
      curl
      fzf
    ];
  };

  home.packages = [
    inputs.ags.packages.${pkgs.system}.default
  ];
}

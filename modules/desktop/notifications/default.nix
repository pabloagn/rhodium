{ pkgs, ... }:
{
  imports = [
    # ./dunst.nix
    ./mako.nix
    # ./tiramisu.nix
  ];

  environment.systemPackages = with pkgs; [
    libnotify
  ];
}

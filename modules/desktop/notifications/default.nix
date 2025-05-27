{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    # tiramisu
    # mako
  ];
}

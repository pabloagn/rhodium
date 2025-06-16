{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  security.polkit.enable = true;
}

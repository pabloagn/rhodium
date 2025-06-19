{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl # Read & control device brightness
    wdisplays # GUI for exploring and setting monitor options
    # TODO: Configure this on Niri
    redshift # Monitor temperature setter
  ];
}

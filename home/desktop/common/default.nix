{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Wayland utils
    wl-mirror # Screen mirroring
    wf-recorder # Screen recording
  ];
}

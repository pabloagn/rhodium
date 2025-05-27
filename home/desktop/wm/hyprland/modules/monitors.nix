{ lib, config, ... }:

# TODO: Add more settings here so the monitors actually work...
{
  monitors = [
    "eDP-1,2880x1620@120,0x0,1.5"
    "HDMI-A-1,auto,auto,mirror,DP-1"
    # "HDMI-A-1,preferred,0x0,2.4"
  ];
}

{ host, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor =
      let
        inherit (host.mainMonitor)
          monitorID
          monitorResolution
          monitorRefreshRate
          monitorScalingFactor
          ;

        # Build monitor string: "ID,resolution@refresh,position,scale"
        resolution = if monitorResolution != "" then monitorResolution else "preferred";
        refresh = if monitorRefreshRate != "" then "@${monitorRefreshRate}" else "";
        scale = if monitorScalingFactor != "" then monitorScalingFactor else "1.0";
      in
      [
        # Main
        "${monitorID},${resolution}${refresh},0x0,${scale}"

        # Common
        "HDMI-A-1,3840x2160@60,0x0,1.5"
      ];
  };
}

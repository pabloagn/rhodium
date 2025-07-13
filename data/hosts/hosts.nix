{
  hosts = {
    host_001 = {
      hostname = "justine";
      description = "Justine Host";
      mainMonitor = {
        monitorID = "eDP-1";
        monitorResolution = "";
        monitorRefreshRate = "120";
        monitorScalingFactor = "1.5";
      };
      defaultLocale = "";
    };

    host_002 = {
      hostname = "alexandria";
      description = "Alexandria Host";
      mainMonitor = {
        monitorID = "eDP-2";
        monitorResolution = "1920x1080";
        monitorRefreshRate = "300";
        monitorScalingFactor = "1.0";
      };
      defaultLocale = "";
    };
  };
}
